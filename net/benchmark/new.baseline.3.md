
=== TCP Upload (client → server) | 192.168.8.219 ===

Connecting to host 192.168.8.219, port 5201
[  4] local 192.168.8.141 port 57680 connected to 192.168.8.219 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  4]   0.00-1.01   sec  3.25 MBytes  27.1 Mbits/sec   99    139 KBytes       
[  4]   1.01-2.00   sec   512 KBytes  4.21 Mbits/sec   11    100 KBytes       
[  4]   2.00-3.00   sec  11.5 MBytes  96.2 Mbits/sec   33    100 KBytes       
[  4]   3.00-4.01   sec  9.88 MBytes  82.8 Mbits/sec   29   91.9 KBytes       
[  4]   4.01-5.00   sec  2.25 MBytes  18.9 Mbits/sec    0    109 KBytes       
[  4]   5.00-6.01   sec  2.00 MBytes  16.8 Mbits/sec    6   89.1 KBytes       
[  4]   6.01-7.01   sec  5.75 MBytes  48.2 Mbits/sec   20    109 KBytes       
[  4]   7.01-8.01   sec  6.25 MBytes  52.4 Mbits/sec    0    154 KBytes       
[  4]   8.01-9.01   sec  3.00 MBytes  25.2 Mbits/sec   21   97.6 KBytes       
[  4]   9.01-10.01  sec  8.38 MBytes  70.2 Mbits/sec   12    103 KBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  4]   0.00-10.01  sec  52.8 MBytes  44.2 Mbits/sec  231            sender
[  4]   0.00-10.01  sec  52.8 MBytes  44.2 Mbits/sec                  receiver

iperf Done.

=== TCP Download (server → client) | 192.168.8.219 ===

Connecting to host 192.168.8.219, port 5201
Reverse mode, remote host 192.168.8.219 is sending
[  4] local 192.168.8.141 port 57686 connected to 192.168.8.219 port 5201
[ ID] Interval           Transfer     Bitrate
[  4]   0.00-1.00   sec  32.1 MBytes   269 Mbits/sec                  
[  4]   1.00-2.00   sec  35.8 MBytes   299 Mbits/sec                  
[  4]   2.00-3.00   sec  35.8 MBytes   300 Mbits/sec                  
[  4]   3.00-4.00   sec  38.0 MBytes   320 Mbits/sec                  
[  4]   4.00-5.00   sec  36.2 MBytes   303 Mbits/sec                  
[  4]   5.00-6.00   sec  35.5 MBytes   298 Mbits/sec                  
[  4]   6.00-7.00   sec  36.5 MBytes   306 Mbits/sec                  
[  4]   7.00-8.00   sec  36.5 MBytes   307 Mbits/sec                  
[  4]   8.00-9.00   sec  37.0 MBytes   311 Mbits/sec                  
[  4]   9.00-10.00  sec  37.5 MBytes   314 Mbits/sec                  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  4]   0.00-10.01  sec   364 MBytes   305 Mbits/sec    2            sender
[  4]   0.00-10.00  sec   361 MBytes   303 Mbits/sec                  receiver

iperf Done.

=== TCP Multi-stream (4 parallel) | 192.168.8.219 ===

Connecting to host 192.168.8.219, port 5201
[  4] local 192.168.8.141 port 57694 connected to 192.168.8.219 port 5201
[  6] local 192.168.8.141 port 57695 connected to 192.168.8.219 port 5201
[  8] local 192.168.8.141 port 57696 connected to 192.168.8.219 port 5201
[ 10] local 192.168.8.141 port 57697 connected to 192.168.8.219 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  4]   0.00-1.00   sec  6.12 MBytes  51.3 Mbits/sec  212   35.4 KBytes       
[  6]   0.00-1.00   sec  6.12 MBytes  51.3 Mbits/sec  196   36.8 KBytes       
[  8]   0.00-1.00   sec  2.00 MBytes  16.8 Mbits/sec   98   35.4 KBytes       
[ 10]   0.00-1.00   sec  4.12 MBytes  34.6 Mbits/sec  106   52.3 KBytes       
[SUM]   0.00-1.00   sec  18.4 MBytes   154 Mbits/sec  612             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   1.00-2.00   sec  3.00 MBytes  25.2 Mbits/sec   48   28.3 KBytes       
[  6]   1.00-2.00   sec  4.50 MBytes  37.8 Mbits/sec  131   26.9 KBytes       
[  8]   1.00-2.00   sec  6.25 MBytes  52.4 Mbits/sec  118   26.9 KBytes       
[ 10]   1.00-2.00   sec  6.75 MBytes  56.6 Mbits/sec  104   58.0 KBytes       
[SUM]   1.00-2.00   sec  20.5 MBytes   172 Mbits/sec  401             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   2.00-3.01   sec  4.12 MBytes  34.5 Mbits/sec   92   33.9 KBytes       
[  6]   2.00-3.01   sec  6.38 MBytes  53.3 Mbits/sec   94   58.0 KBytes       
[  8]   2.00-3.01   sec  5.00 MBytes  41.8 Mbits/sec   85   43.8 KBytes       
[ 10]   2.00-3.01   sec  5.00 MBytes  41.8 Mbits/sec   73   18.4 KBytes       
[SUM]   2.00-3.01   sec  20.5 MBytes   171 Mbits/sec  344             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   3.01-4.00   sec  2.88 MBytes  24.2 Mbits/sec  109   22.6 KBytes       
[  6]   3.01-4.00   sec  5.88 MBytes  49.5 Mbits/sec   91   43.8 KBytes       
[  8]   3.01-4.00   sec  4.88 MBytes  41.1 Mbits/sec  162   28.3 KBytes       
[ 10]   3.01-4.00   sec  5.38 MBytes  45.3 Mbits/sec  102   53.7 KBytes       
[SUM]   3.01-4.00   sec  19.0 MBytes   160 Mbits/sec  464             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   4.00-5.00   sec  4.38 MBytes  36.7 Mbits/sec  137   36.8 KBytes       
[  6]   4.00-5.00   sec  5.12 MBytes  43.0 Mbits/sec  134   32.5 KBytes       
[  8]   4.00-5.00   sec  4.00 MBytes  33.6 Mbits/sec  125   58.0 KBytes       
[ 10]   4.00-5.00   sec  6.75 MBytes  56.6 Mbits/sec   90   17.0 KBytes       
[SUM]   4.00-5.00   sec  20.2 MBytes   170 Mbits/sec  486             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   5.00-6.01   sec  5.88 MBytes  49.1 Mbits/sec   76   26.9 KBytes       
[  6]   5.00-6.01   sec  3.75 MBytes  31.3 Mbits/sec  103   36.8 KBytes       
[  8]   5.00-6.01   sec  4.38 MBytes  36.5 Mbits/sec  108   0.00 Bytes       
[ 10]   5.00-6.01   sec  7.12 MBytes  59.5 Mbits/sec  105   73.5 KBytes       
[SUM]   5.00-6.01   sec  21.1 MBytes   176 Mbits/sec  392             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   6.01-7.00   sec  5.62 MBytes  47.2 Mbits/sec   69   33.9 KBytes       
[  6]   6.01-7.00   sec  8.38 MBytes  70.3 Mbits/sec   86   82.0 KBytes       
[  8]   6.01-7.00   sec  0.00 Bytes  0.00 bits/sec    0   0.00 Bytes       
[ 10]   6.01-7.00   sec  6.38 MBytes  53.5 Mbits/sec   85   32.5 KBytes       
[SUM]   6.01-7.00   sec  20.4 MBytes   171 Mbits/sec  240             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   7.00-8.00   sec  3.88 MBytes  32.6 Mbits/sec   76   50.9 KBytes       
[  6]   7.00-8.00   sec  6.88 MBytes  57.9 Mbits/sec  136   49.5 KBytes       
[  8]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec    0   0.00 Bytes       
[ 10]   7.00-8.00   sec  7.88 MBytes  66.3 Mbits/sec   66   32.5 KBytes       
[SUM]   7.00-8.00   sec  18.6 MBytes   157 Mbits/sec  278             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   8.00-9.00   sec  5.88 MBytes  49.3 Mbits/sec   56   72.1 KBytes       
[  6]   8.00-9.00   sec  6.88 MBytes  57.7 Mbits/sec  105   42.4 KBytes       
[  8]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec    0   0.00 Bytes       
[ 10]   8.00-9.00   sec  6.12 MBytes  51.4 Mbits/sec  125   43.8 KBytes       
[SUM]   8.00-9.00   sec  18.9 MBytes   158 Mbits/sec  286             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   9.00-10.00  sec  7.00 MBytes  58.7 Mbits/sec   94   60.8 KBytes       
[  6]   9.00-10.00  sec  5.25 MBytes  44.0 Mbits/sec  110   41.0 KBytes       
[  8]   9.00-10.00  sec  0.00 Bytes  0.00 bits/sec    0   0.00 Bytes       
[ 10]   9.00-10.00  sec  6.88 MBytes  57.7 Mbits/sec  127   65.0 KBytes       
[SUM]   9.00-10.00  sec  19.1 MBytes   160 Mbits/sec  331             
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  4]   0.00-10.00  sec  48.8 MBytes  40.9 Mbits/sec  969            sender
[  4]   0.00-10.01  sec  48.6 MBytes  40.8 Mbits/sec                  receiver
[  6]   0.00-10.00  sec  59.1 MBytes  49.6 Mbits/sec  1186            sender
[  6]   0.00-10.01  sec  59.0 MBytes  49.5 Mbits/sec                  receiver
[  8]   0.00-10.00  sec  26.5 MBytes  22.2 Mbits/sec  696            sender
[  8]   0.00-10.01  sec  26.4 MBytes  22.1 Mbits/sec                  receiver
[ 10]   0.00-10.00  sec  62.4 MBytes  52.3 Mbits/sec  983            sender
[ 10]   0.00-10.01  sec  62.4 MBytes  52.3 Mbits/sec                  receiver
[SUM]   0.00-10.00  sec   197 MBytes   165 Mbits/sec  3834             sender
[SUM]   0.00-10.01  sec   196 MBytes   165 Mbits/sec                  receiver

iperf Done.

=== UDP | 192.168.8.219 ===

Connecting to host 192.168.8.219, port 5201
[  4] local 192.168.8.141 port 53995 connected to 192.168.8.219 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  4]   0.00-1.00   sec  29.9 MBytes   250 Mbits/sec  21651  
[  4]   1.00-2.00   sec  29.7 MBytes   250 Mbits/sec  21513  
[  4]   2.00-3.00   sec  29.8 MBytes   250 Mbits/sec  21604  
[  4]   3.00-4.00   sec  29.8 MBytes   250 Mbits/sec  21561  
[  4]   4.00-5.00   sec  29.8 MBytes   250 Mbits/sec  21580  
[  4]   5.00-6.00   sec  29.8 MBytes   250 Mbits/sec  21585  
[  4]   6.00-7.00   sec  29.8 MBytes   250 Mbits/sec  21588  
[  4]   7.00-8.00   sec  29.8 MBytes   250 Mbits/sec  21575  
[  4]   8.00-9.00   sec  29.8 MBytes   250 Mbits/sec  21586  
[  4]   9.00-10.00  sec  29.8 MBytes   250 Mbits/sec  21577  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  4]   0.00-10.00  sec   298 MBytes   250 Mbits/sec  0.000 ms  0/215820 (0%)  sender
[  4]   0.00-10.01  sec   264 MBytes   222 Mbits/sec  0.049 ms  24422/215820 (11%)  receiver

iperf Done.
