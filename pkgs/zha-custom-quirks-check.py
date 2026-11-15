"""Load a ZHA custom quirks directory the way ZHA does and sanity check it.

Fails if a quirk module doesn't import, registers no quirk, or targets a device
that zha-quirks now supports itself (time to drop the custom quirk).
"""

import logging
import pathlib
import sys

import zhaquirks
from zha.quirks import DEVICE_REGISTRY


def main(root: pathlib.Path) -> int:
    errors = []

    # Surface quirk import failures; ZHA would only log them and move on.
    class Collect(logging.Handler):
        def emit(self, record):
            if record.levelno >= logging.ERROR:
                message = record.getMessage()
                if record.exc_info:
                    message += f": {record.exc_info[1]!r}"
                errors.append(message)

    logging.getLogger("zhaquirks").addHandler(Collect())

    zhaquirks.setup(custom_quirks_path=str(root))

    def is_custom(entry):
        file = entry.source and entry.source.file
        return file is not None and pathlib.Path(file).is_relative_to(root)

    entries = list(DEVICE_REGISTRY)
    custom = [e for e in entries if is_custom(e)]
    builtin = [e for e in entries if not is_custom(e)]

    for module in sorted(root.glob("*.py")):
        registered = [
            e for e in custom if pathlib.Path(e.source.file).name == module.name
        ]
        if not registered:
            errors.append(f"{module.name}: registered no quirks")
        print(module.name)
        for entry in registered:
            match = entry.device_match
            models = ", ".join(f"{mfr}/{model}" for mfr, model in match.applies_to)
            fw = ""
            if (
                match.firmware_version_min is not None
                or match.firmware_version_max is not None
            ):
                lo = match.firmware_version_min
                hi = match.firmware_version_max
                fw = f" firmware [{lo and hex(lo)}, {hi and hex(hi)})"
            print(f"  {models}{fw}")
            definition = getattr(entry.zha_device_factory, "quirk_definition", None)
            for meta in getattr(definition, "entity_metadata", ()):
                print(f"    {meta.entity_platform.value}: {meta.fallback_name}")

            # zha-quirks shipping its own quirk for the same device means ours
            # is redundant at best and competing with it at worst.
            for other in builtin:
                overlap = set(match.applies_to) & set(other.device_match.applies_to)
                for mfr, model in sorted(overlap):
                    errors.append(
                        f"{module.name}: zha-quirks now ships {other.source.module}"
                        f" for {mfr}/{model}; remove the custom quirk"
                    )

    for error in dict.fromkeys(errors):
        print(f"error: {error}", file=sys.stderr)
    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(main(pathlib.Path(sys.argv[1])))
