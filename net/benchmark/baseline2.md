
=== TCP Upload (client → server) | 192.168.1.93 ===

Connecting to host 192.168.1.93, port 5201
[  4] local 192.168.1.70 port 57244 connected to 192.168.1.93 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  4]   0.00-1.00   sec  34.0 MBytes   285 Mbits/sec    0   7.93 MBytes       
[  4]   1.00-2.01   sec  37.6 MBytes   315 Mbits/sec    0   7.97 MBytes       
[  4]   2.01-3.00   sec  19.2 MBytes   162 Mbits/sec    0   7.97 MBytes       
[  4]   3.00-4.00   sec  22.0 MBytes   184 Mbits/sec    0   7.97 MBytes       
[  4]   4.00-5.00   sec  20.1 MBytes   169 Mbits/sec    2   7.97 MBytes       
[  4]   5.00-6.00   sec  25.6 MBytes   216 Mbits/sec    0   8.00 MBytes       
[  4]   6.00-7.00   sec  16.9 MBytes   141 Mbits/sec    1   8.00 MBytes       
[  4]   7.00-8.01   sec  23.5 MBytes   197 Mbits/sec    0   8.00 MBytes       
[  4]   8.01-9.00   sec  22.8 MBytes   191 Mbits/sec    0   8.00 MBytes       
[  4]   9.00-10.00  sec  32.5 MBytes   273 Mbits/sec    0   8.00 MBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  4]   0.00-10.00  sec   254 MBytes   213 Mbits/sec    3            sender
[  4]   0.00-10.03  sec   254 MBytes   213 Mbits/sec                  receiver

iperf Done.

=== TCP Download (server → client) | 192.168.1.93 ===

Connecting to host 192.168.1.93, port 5201
Reverse mode, remote host 192.168.1.93 is sending
[  4] local 192.168.1.70 port 57252 connected to 192.168.1.93 port 5201
[ ID] Interval           Transfer     Bitrate
[  4]   0.00-1.00   sec  10.9 MBytes  91.2 Mbits/sec                  
[  4]   1.00-2.00   sec  18.5 MBytes   155 Mbits/sec                  
[  4]   2.00-3.01   sec  21.6 MBytes   181 Mbits/sec                  
[  4]   3.01-4.00   sec  24.6 MBytes   208 Mbits/sec                  
[  4]   4.00-5.00   sec  27.2 MBytes   229 Mbits/sec                  
[  4]   5.00-6.00   sec  26.6 MBytes   223 Mbits/sec                  
[  4]   6.00-7.00   sec  32.0 MBytes   268 Mbits/sec                  
[  4]   7.00-8.00   sec  46.0 MBytes   386 Mbits/sec                  
[  4]   8.00-9.00   sec  42.6 MBytes   356 Mbits/sec                  
[  4]   9.00-10.00  sec  42.2 MBytes   355 Mbits/sec                  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  4]   0.00-10.05  sec   295 MBytes   246 Mbits/sec    1            sender
[  4]   0.00-10.00  sec   292 MBytes   245 Mbits/sec                  receiver

iperf Done.

=== TCP Multi-stream (4 parallel) | 192.168.1.93 ===

Connecting to host 192.168.1.93, port 5201
[  4] local 192.168.1.70 port 57261 connected to 192.168.1.93 port 5201
[  6] local 192.168.1.70 port 57262 connected to 192.168.1.93 port 5201
[  8] local 192.168.1.70 port 57263 connected to 192.168.1.93 port 5201
[ 10] local 192.168.1.70 port 57264 connected to 192.168.1.93 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  4]   0.00-1.00   sec  9.38 MBytes  78.5 Mbits/sec  525   1.44 MBytes       
[  6]   0.00-1.00   sec  8.62 MBytes  72.2 Mbits/sec  519   2.80 MBytes       
[  8]   0.00-1.00   sec  8.00 MBytes  67.0 Mbits/sec  432   2.44 MBytes       
[ 10]   0.00-1.00   sec  7.62 MBytes  63.8 Mbits/sec  581   1.13 MBytes       
[SUM]   0.00-1.00   sec  33.6 MBytes   282 Mbits/sec  2057             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   1.00-2.00   sec  3.75 MBytes  31.4 Mbits/sec    4    666 KBytes       
[  6]   1.00-2.00   sec  3.12 MBytes  26.2 Mbits/sec    0    362 KBytes       
[  8]   1.00-2.00   sec  15.4 MBytes   129 Mbits/sec  273   1.74 MBytes       
[ 10]   1.00-2.00   sec  13.2 MBytes   111 Mbits/sec  408   1.45 MBytes       
[SUM]   1.00-2.00   sec  35.5 MBytes   297 Mbits/sec  685             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   2.00-3.00   sec  3.50 MBytes  29.5 Mbits/sec    0    711 KBytes       
[  6]   2.00-3.00   sec  11.8 MBytes  98.9 Mbits/sec    0   2.87 MBytes       
[  8]   2.00-3.00   sec  9.00 MBytes  75.7 Mbits/sec    0   1.83 MBytes       
[ 10]   2.00-3.00   sec  11.9 MBytes  99.9 Mbits/sec    0   1.94 MBytes       
[SUM]   2.00-3.00   sec  36.1 MBytes   304 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   3.00-4.00   sec  4.38 MBytes  36.6 Mbits/sec    0    757 KBytes       
[  6]   3.00-4.00   sec  11.4 MBytes  95.2 Mbits/sec  753   2.08 MBytes       
[  8]   3.00-4.00   sec  11.4 MBytes  95.2 Mbits/sec    0   1.93 MBytes       
[ 10]   3.00-4.00   sec  12.0 MBytes   100 Mbits/sec    0   2.04 MBytes       
[SUM]   3.00-4.00   sec  39.1 MBytes   327 Mbits/sec  753             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   4.00-5.00   sec  4.50 MBytes  37.7 Mbits/sec    0    782 KBytes       
[  6]   4.00-5.00   sec  11.5 MBytes  96.4 Mbits/sec   34   1.54 MBytes       
[  8]   4.00-5.00   sec  10.5 MBytes  88.0 Mbits/sec    0   2.00 MBytes       
[ 10]   4.00-5.00   sec  11.0 MBytes  92.2 Mbits/sec    0   2.11 MBytes       
[SUM]   4.00-5.00   sec  37.5 MBytes   314 Mbits/sec   34             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   5.00-6.00   sec  4.38 MBytes  36.7 Mbits/sec    0    796 KBytes       
[  6]   5.00-6.00   sec  7.75 MBytes  65.1 Mbits/sec   48   1.60 MBytes       
[  8]   5.00-6.00   sec  11.8 MBytes  98.7 Mbits/sec    0   2.05 MBytes       
[ 10]   5.00-6.00   sec  12.2 MBytes   103 Mbits/sec    0   2.17 MBytes       
[SUM]   5.00-6.00   sec  36.1 MBytes   303 Mbits/sec   48             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   6.00-7.00   sec  4.38 MBytes  36.8 Mbits/sec    0    802 KBytes       
[  6]   6.00-7.00   sec  9.88 MBytes  83.0 Mbits/sec    0   1.70 MBytes       
[  8]   6.00-7.00   sec  10.9 MBytes  91.5 Mbits/sec    0   2.08 MBytes       
[ 10]   6.00-7.00   sec  11.1 MBytes  93.6 Mbits/sec    0   2.20 MBytes       
[SUM]   6.00-7.00   sec  36.2 MBytes   305 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   7.00-8.00   sec  3.50 MBytes  29.4 Mbits/sec   16    584 KBytes       
[  6]   7.00-8.00   sec  7.00 MBytes  58.7 Mbits/sec   24   1.22 MBytes       
[  8]   7.00-8.00   sec  13.9 MBytes   116 Mbits/sec    0   2.10 MBytes       
[ 10]   7.00-8.00   sec  11.5 MBytes  96.4 Mbits/sec   64   1.58 MBytes       
[SUM]   7.00-8.00   sec  35.9 MBytes   301 Mbits/sec  104             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   8.00-9.00   sec  2.50 MBytes  21.0 Mbits/sec    0    669 KBytes       
[  6]   8.00-9.00   sec  4.88 MBytes  40.9 Mbits/sec    0   1.32 MBytes       
[  8]   8.00-9.00   sec  7.12 MBytes  59.7 Mbits/sec    0   2.11 MBytes       
[ 10]   8.00-9.00   sec  4.62 MBytes  38.8 Mbits/sec    1   1.59 MBytes       
[SUM]   8.00-9.00   sec  19.1 MBytes   160 Mbits/sec    1             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   9.00-10.01  sec  2.88 MBytes  24.0 Mbits/sec    0    720 KBytes       
[  6]   9.00-10.01  sec  5.88 MBytes  49.1 Mbits/sec    0   1.37 MBytes       
[  8]   9.00-10.01  sec  8.38 MBytes  70.0 Mbits/sec    0   2.11 MBytes       
[ 10]   9.00-10.01  sec  6.50 MBytes  54.3 Mbits/sec    0   1.59 MBytes       
[SUM]   9.00-10.01  sec  23.6 MBytes   197 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  4]   0.00-10.01  sec  43.1 MBytes  36.2 Mbits/sec  545            sender
[  4]   0.00-10.12  sec  42.4 MBytes  35.1 Mbits/sec                  receiver
[  6]   0.00-10.01  sec  81.8 MBytes  68.5 Mbits/sec  1378            sender
[  6]   0.00-10.12  sec  80.4 MBytes  66.6 Mbits/sec                  receiver
[  8]   0.00-10.01  sec   106 MBytes  89.1 Mbits/sec  705            sender
[  8]   0.00-10.12  sec   104 MBytes  86.5 Mbits/sec                  receiver
[ 10]   0.00-10.01  sec   102 MBytes  85.3 Mbits/sec  1054            sender
[ 10]   0.00-10.12  sec   100 MBytes  83.0 Mbits/sec                  receiver
[SUM]   0.00-10.01  sec   333 MBytes   279 Mbits/sec  3682             sender
[SUM]   0.00-10.12  sec   327 MBytes   271 Mbits/sec                  receiver

iperf Done.

=== UDP | 192.168.1.93 ===

Connecting to host 192.168.1.93, port 5201
[  4] local 192.168.1.70 port 58240 connected to 192.168.1.93 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  4]   0.00-1.00   sec  29.9 MBytes   250 Mbits/sec  21642  
[  4]   1.00-2.01   sec  29.9 MBytes   250 Mbits/sec  21629  
[  4]   2.01-3.01   sec  29.8 MBytes   250 Mbits/sec  21582  
[  4]   3.01-4.00   sec  29.7 MBytes   250 Mbits/sec  21474  
[  4]   4.00-5.00   sec  29.8 MBytes   250 Mbits/sec  21582  
[  4]   5.00-6.00   sec  29.8 MBytes   250 Mbits/sec  21601  
[  4]   6.00-7.00   sec  29.8 MBytes   250 Mbits/sec  21573  
[  4]   7.00-8.00   sec  29.8 MBytes   250 Mbits/sec  21575  
[  4]   8.00-9.00   sec  29.9 MBytes   250 Mbits/sec  21622  
[  4]   9.00-10.00  sec  29.8 MBytes   250 Mbits/sec  21566  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  4]   0.00-10.00  sec   298 MBytes   250 Mbits/sec  0.000 ms  0/215846 (0%)  sender
[  4]   0.00-10.08  sec   291 MBytes   242 Mbits/sec  0.043 ms  3352/214085 (1.6%)  receiver

iperf Done.
