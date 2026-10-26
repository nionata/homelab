
=== TCP Upload (client → server) | 192.168.1.93 ===

Connecting to host 192.168.1.93, port 5201
[  4] local 192.168.1.70 port 57309 connected to 192.168.1.93 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  4]   0.00-1.01   sec  20.4 MBytes   170 Mbits/sec    0   7.97 MBytes       
[  4]   1.01-2.00   sec  23.9 MBytes   201 Mbits/sec    0   7.97 MBytes       
[  4]   2.00-3.00   sec  13.5 MBytes   113 Mbits/sec    2   7.78 MBytes       
[  4]   3.00-4.00   sec  21.6 MBytes   181 Mbits/sec    0   7.97 MBytes       
[  4]   4.00-5.00   sec  13.1 MBytes   110 Mbits/sec   16   0.00 Bytes       
[  4]   5.00-6.01   sec  5.88 MBytes  49.1 Mbits/sec   10   2.53 MBytes       
[  4]   6.01-7.00   sec  18.8 MBytes   158 Mbits/sec    0   2.92 MBytes       
[  4]   7.00-8.01   sec  36.1 MBytes   302 Mbits/sec    0   3.05 MBytes       
[  4]   8.01-9.01   sec  17.0 MBytes   143 Mbits/sec    0   3.14 MBytes       
[  4]   9.01-10.01  sec  22.1 MBytes   186 Mbits/sec    0   3.23 MBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  4]   0.00-10.01  sec   192 MBytes   161 Mbits/sec   28            sender
[  4]   0.00-10.09  sec   192 MBytes   159 Mbits/sec                  receiver

iperf Done.

=== TCP Download (server → client) | 192.168.1.93 ===

Connecting to host 192.168.1.93, port 5201
Reverse mode, remote host 192.168.1.93 is sending
[  4] local 192.168.1.70 port 57318 connected to 192.168.1.93 port 5201
[ ID] Interval           Transfer     Bitrate
[  4]   0.00-1.01   sec  15.1 MBytes   126 Mbits/sec                  
[  4]   1.01-2.00   sec  19.8 MBytes   166 Mbits/sec                  
[  4]   2.00-3.00   sec  22.4 MBytes   187 Mbits/sec                  
[  4]   3.00-4.00   sec  29.0 MBytes   243 Mbits/sec                  
[  4]   4.00-5.00   sec  27.0 MBytes   226 Mbits/sec                  
[  4]   5.00-6.00   sec  39.2 MBytes   330 Mbits/sec                  
[  4]   6.00-7.00   sec  46.9 MBytes   392 Mbits/sec                  
[  4]   7.00-8.00   sec  44.6 MBytes   375 Mbits/sec                  
[  4]   8.00-9.00   sec  44.5 MBytes   374 Mbits/sec                  
[  4]   9.00-10.00  sec  45.6 MBytes   382 Mbits/sec                  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  4]   0.00-10.09  sec   337 MBytes   280 Mbits/sec    2            sender
[  4]   0.00-10.00  sec   334 MBytes   280 Mbits/sec                  receiver

iperf Done.

=== TCP Multi-stream (4 parallel) | 192.168.1.93 ===

Connecting to host 192.168.1.93, port 5201
[  4] local 192.168.1.70 port 57324 connected to 192.168.1.93 port 5201
[  6] local 192.168.1.70 port 57325 connected to 192.168.1.93 port 5201
[  8] local 192.168.1.70 port 57326 connected to 192.168.1.93 port 5201
[ 10] local 192.168.1.70 port 57327 connected to 192.168.1.93 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  4]   0.00-1.00   sec  10.1 MBytes  84.7 Mbits/sec    0   4.66 MBytes       
[  6]   0.00-1.00   sec  8.62 MBytes  72.1 Mbits/sec    0   4.00 MBytes       
[  8]   0.00-1.00   sec  8.12 MBytes  67.9 Mbits/sec    0   4.00 MBytes       
[ 10]   0.00-1.00   sec  8.25 MBytes  69.0 Mbits/sec    0   4.00 MBytes       
[SUM]   0.00-1.00   sec  35.1 MBytes   294 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   1.00-2.00   sec  10.0 MBytes  83.9 Mbits/sec   88    607 KBytes       
[  6]   1.00-2.00   sec  9.75 MBytes  81.8 Mbits/sec  129    491 KBytes       
[  8]   1.00-2.00   sec  17.4 MBytes   146 Mbits/sec    0   7.99 MBytes       
[ 10]   1.00-2.00   sec  8.25 MBytes  69.2 Mbits/sec   76   5.66 KBytes       
[SUM]   1.00-2.00   sec  45.4 MBytes   381 Mbits/sec  293             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   2.00-3.01   sec  5.75 MBytes  48.1 Mbits/sec  182   1.51 MBytes       
[  6]   2.00-3.01   sec  16.1 MBytes   135 Mbits/sec    0   4.25 MBytes       
[  8]   2.00-3.01   sec  10.4 MBytes  86.9 Mbits/sec  660    882 KBytes       
[ 10]   2.00-3.01   sec   384 KBytes  3.14 Mbits/sec    0    362 KBytes       
[SUM]   2.00-3.01   sec  32.6 MBytes   273 Mbits/sec  842             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   3.01-4.00   sec  6.25 MBytes  52.5 Mbits/sec    0   1.59 MBytes       
[  6]   3.01-4.00   sec  16.0 MBytes   134 Mbits/sec    8   2.08 MBytes       
[  8]   3.01-4.00   sec  8.62 MBytes  72.5 Mbits/sec    0   2.81 MBytes       
[ 10]   3.01-4.00   sec  7.62 MBytes  64.1 Mbits/sec    1   2.43 MBytes       
[SUM]   3.01-4.00   sec  38.5 MBytes   323 Mbits/sec    9             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   4.00-5.01   sec  6.25 MBytes  52.4 Mbits/sec   45   1.16 MBytes       
[  6]   4.00-5.01   sec  10.1 MBytes  84.8 Mbits/sec   63   2.56 MBytes       
[  8]   4.00-5.01   sec  11.1 MBytes  93.2 Mbits/sec  454   2.03 MBytes       
[ 10]   4.00-5.01   sec  11.0 MBytes  92.1 Mbits/sec  691   2.04 MBytes       
[SUM]   4.00-5.01   sec  38.5 MBytes   323 Mbits/sec  1253             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   5.01-6.01   sec  4.25 MBytes  35.7 Mbits/sec  235    868 KBytes       
[  6]   5.01-6.01   sec  11.1 MBytes  93.3 Mbits/sec  648   1.85 MBytes       
[  8]   5.01-6.01   sec  11.1 MBytes  93.3 Mbits/sec  119   1.50 MBytes       
[ 10]   5.01-6.01   sec  7.88 MBytes  66.1 Mbits/sec  681   1.48 MBytes       
[SUM]   5.01-6.01   sec  34.4 MBytes   288 Mbits/sec  1683             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   6.01-7.00   sec  2.62 MBytes  22.1 Mbits/sec    0    898 KBytes       
[  6]   6.01-7.00   sec  5.38 MBytes  45.3 Mbits/sec    0   1.90 MBytes       
[  8]   6.01-7.00   sec  3.00 MBytes  25.3 Mbits/sec    0   1.53 MBytes       
[ 10]   6.01-7.00   sec  3.88 MBytes  32.6 Mbits/sec    0   1.52 MBytes       
[SUM]   6.01-7.00   sec  14.9 MBytes   125 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   7.00-8.00   sec  1.75 MBytes  14.7 Mbits/sec    1    641 KBytes       
[  6]   7.00-8.00   sec  12.6 MBytes   106 Mbits/sec    0   2.05 MBytes       
[  8]   7.00-8.00   sec  3.75 MBytes  31.5 Mbits/sec    4   1.11 MBytes       
[ 10]   7.00-8.00   sec  6.50 MBytes  54.5 Mbits/sec   27   1.14 MBytes       
[SUM]   7.00-8.00   sec  24.6 MBytes   207 Mbits/sec   32             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   8.00-9.01   sec  3.12 MBytes  26.1 Mbits/sec    0    694 KBytes       
[  6]   8.00-9.01   sec  8.62 MBytes  72.0 Mbits/sec    0   2.11 MBytes       
[  8]   8.00-9.01   sec  4.75 MBytes  39.7 Mbits/sec    0   1.18 MBytes       
[ 10]   8.00-9.01   sec  4.75 MBytes  39.7 Mbits/sec    0   1.19 MBytes       
[SUM]   8.00-9.01   sec  21.2 MBytes   177 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   9.01-10.00  sec  1.38 MBytes  11.6 Mbits/sec   27   91.9 KBytes       
[  6]   9.01-10.00  sec  6.12 MBytes  51.5 Mbits/sec  318   1.49 MBytes       
[  8]   9.01-10.00  sec  2.38 MBytes  20.0 Mbits/sec   10    110 KBytes       
[ 10]   9.01-10.00  sec  4.88 MBytes  41.0 Mbits/sec    0   1.24 MBytes       
[SUM]   9.01-10.00  sec  14.8 MBytes   124 Mbits/sec  355             
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  4]   0.00-10.00  sec  51.5 MBytes  43.2 Mbits/sec  578            sender
[  4]   0.00-10.01  sec  50.9 MBytes  42.6 Mbits/sec                  receiver
[  6]   0.00-10.00  sec   104 MBytes  87.6 Mbits/sec  1166            sender
[  6]   0.00-10.01  sec   103 MBytes  86.3 Mbits/sec                  receiver
[  8]   0.00-10.00  sec  80.6 MBytes  67.6 Mbits/sec  1247            sender
[  8]   0.00-10.01  sec  79.5 MBytes  66.6 Mbits/sec                  receiver
[ 10]   0.00-10.00  sec  63.4 MBytes  53.1 Mbits/sec  1476            sender
[ 10]   0.00-10.01  sec  62.1 MBytes  52.0 Mbits/sec                  receiver
[SUM]   0.00-10.00  sec   300 MBytes   252 Mbits/sec  4467             sender
[SUM]   0.00-10.01  sec   296 MBytes   248 Mbits/sec                  receiver

iperf Done.

=== UDP | 192.168.1.93 ===

Connecting to host 192.168.1.93, port 5201
[  4] local 192.168.1.70 port 51246 connected to 192.168.1.93 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  4]   0.00-1.01   sec  30.0 MBytes   250 Mbits/sec  21690  
[  4]   1.01-2.01   sec  24.1 MBytes   202 Mbits/sec  17421  
[  4]   2.01-3.01   sec  24.8 MBytes   208 Mbits/sec  17927  
[  4]   3.01-4.01   sec  36.3 MBytes   304 Mbits/sec  26254  
[  4]   4.01-5.01   sec  30.3 MBytes   254 Mbits/sec  21923  
[  4]   5.01-6.01   sec  24.9 MBytes   209 Mbits/sec  18051  
[  4]   6.01-7.01   sec  27.5 MBytes   230 Mbits/sec  19894  
[  4]   7.01-8.01   sec  36.7 MBytes   307 Mbits/sec  26541  
[  4]   8.01-9.01   sec  30.1 MBytes   253 Mbits/sec  21807  
[  4]   9.01-10.01  sec  12.9 MBytes   109 Mbits/sec  9375  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  4]   0.00-10.01  sec   277 MBytes   233 Mbits/sec  0.000 ms  0/200883 (0%)  sender
[  4]   0.00-10.54  sec   247 MBytes   197 Mbits/sec  0.018 ms  20567/199311 (10%)  receiver

iperf Done.
