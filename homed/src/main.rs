use std::collections::HashMap;

pub struct Account {
    balance: i64,
}

impl Account {
    pub fn new() -> Account {
        Account { balance: 0 }
    }

    pub fn deposit(&mut self, amt: i64) -> i64 {
        self.balance += amt;
        self.balance
    }

    pub fn withdraw(&mut self, amt: i64) -> i64 {
        self.balance -= amt;
        self.balance
    }
}

pub struct Bank {
    accounts: HashMap<String, Account>,
}

impl Bank {
    pub fn new() -> Bank {
        Bank {
            accounts: HashMap::new(),
        }
    }

    pub fn new_account(&mut self, name: String) {
        self.accounts.insert(name, Account::new());
    }

    pub fn get_account(&mut self, name: &str) -> Option<&mut Account> {
        self.accounts.get_mut(name)
    }
}

pub enum Action {
    Deposit,
    Withdraw,
}

fn main() {
    println!("Enter your name to create an account:");
    let mut buffer = String::new();
    std::io::stdin().read_line(&mut buffer).unwrap();

    let mut bank = Bank::new();
    bank.new_account(buffer.clone());

    let account = bank.get_account(&buffer).unwrap();

    loop {
        println!("Your account balance is: {}", account.balance);
        println!("What would you like to do next: deposit (d) / withdrwaw (w)");

        let mut buffer = String::new();
        std::io::stdin().read_line(&mut buffer).unwrap();
        let buffer = buffer.trim();

        let action;

        if buffer == "d" {
            action = Action::Deposit;
        } else if buffer == "w" {
            action = Action::Withdraw;
        } else {
            println!("Incorrect command {:?}", buffer);
            continue;
        }

        println!("Ammount:");

        let mut buffer = String::new();
        std::io::stdin().read_line(&mut buffer).unwrap();
        let buffer = buffer.trim();

        let value = match buffer.parse::<i64>() {
            Ok(value) => value,
            Err(_error) => {
                println!("Invalid ammount {}", buffer);
                continue;
            }
        };

        let _balance = match action {
            Action::Deposit => account.deposit(value),
            Action::Withdraw => account.withdraw(value),
        };
    }
}

// fn main() {
//     let pid = std::process::id();

//     println!("Hello, system! PID: {}", pid);
// }
