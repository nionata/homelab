
=== TCP Upload (client → server) | 192.168.8.219 ===

Connecting to host 192.168.8.219, port 5201
[  4] local 192.168.8.141 port 57352 connected to 192.168.8.219 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  4]   0.00-1.01   sec  43.5 MBytes   363 Mbits/sec    0   7.87 MBytes       
[  4]   1.01-2.00   sec  43.9 MBytes   370 Mbits/sec    0   7.97 MBytes       
[  4]   2.00-3.00   sec  41.0 MBytes   344 Mbits/sec    0   7.97 MBytes       
[  4]   3.00-4.00   sec  42.8 MBytes   358 Mbits/sec    0   7.97 MBytes       
[  4]   4.00-5.00   sec  23.4 MBytes   196 Mbits/sec    0   7.97 MBytes       
[  4]   5.00-6.00   sec  25.1 MBytes   211 Mbits/sec    2   7.97 MBytes       
[  4]   6.00-7.01   sec  23.4 MBytes   196 Mbits/sec    0   7.97 MBytes       
[  4]   7.01-8.00   sec  27.1 MBytes   228 Mbits/sec    0   7.97 MBytes       
[  4]   8.00-9.01   sec  27.5 MBytes   231 Mbits/sec    0   7.97 MBytes       
[  4]   9.01-10.01  sec  27.6 MBytes   232 Mbits/sec    0   7.97 MBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  4]   0.00-10.01  sec   325 MBytes   273 Mbits/sec    2            sender
[  4]   0.00-10.17  sec   325 MBytes   268 Mbits/sec                  receiver

iperf Done.

=== TCP Download (server → client) | 192.168.8.219 ===

Connecting to host 192.168.8.219, port 5201
Reverse mode, remote host 192.168.8.219 is sending
[  4] local 192.168.8.141 port 57358 connected to 192.168.8.219 port 5201
[ ID] Interval           Transfer     Bitrate
[  4]   0.00-1.00   sec  19.9 MBytes   166 Mbits/sec                  
[  4]   1.00-2.00   sec  28.0 MBytes   235 Mbits/sec                  
[  4]   2.00-3.01   sec  30.0 MBytes   251 Mbits/sec                  
[  4]   3.01-4.00   sec  14.9 MBytes   125 Mbits/sec                  
[  4]   4.00-5.01   sec  13.9 MBytes   116 Mbits/sec                  
[  4]   5.01-6.01   sec  14.6 MBytes   123 Mbits/sec                  
[  4]   6.01-7.00   sec  13.2 MBytes   112 Mbits/sec                  
[  4]   7.00-8.00   sec  19.4 MBytes   162 Mbits/sec                  
[  4]   8.00-9.01   sec  20.2 MBytes   169 Mbits/sec                  
[  4]   9.01-10.00  sec  33.2 MBytes   280 Mbits/sec                  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  4]   0.00-10.10  sec   210 MBytes   175 Mbits/sec   93            sender
[  4]   0.00-10.00  sec   207 MBytes   174 Mbits/sec                  receiver

iperf Done.

=== TCP Multi-stream (4 parallel) | 192.168.8.219 ===

Connecting to host 192.168.8.219, port 5201
[  4] local 192.168.8.141 port 57366 connected to 192.168.8.219 port 5201
[  6] local 192.168.8.141 port 57367 connected to 192.168.8.219 port 5201
[  8] local 192.168.8.141 port 57368 connected to 192.168.8.219 port 5201
[ 10] local 192.168.8.141 port 57369 connected to 192.168.8.219 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  4]   0.00-1.00   sec  14.1 MBytes   118 Mbits/sec  862   1.62 MBytes       
[  6]   0.00-1.00   sec  13.6 MBytes   114 Mbits/sec  940   2.31 MBytes       
[  8]   0.00-1.00   sec  15.0 MBytes   125 Mbits/sec  774   1.77 MBytes       
[ 10]   0.00-1.00   sec  13.6 MBytes   114 Mbits/sec  437   2.38 MBytes       
[SUM]   0.00-1.00   sec  56.4 MBytes   471 Mbits/sec  3013             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   1.00-2.00   sec  11.4 MBytes  95.6 Mbits/sec    0   2.05 MBytes       
[  6]   1.00-2.00   sec  9.88 MBytes  83.0 Mbits/sec    0   2.18 MBytes       
[  8]   1.00-2.00   sec  9.88 MBytes  83.0 Mbits/sec    0   1.70 MBytes       
[ 10]   1.00-2.00   sec  8.38 MBytes  70.4 Mbits/sec    0   1.61 MBytes       
[SUM]   1.00-2.00   sec  39.5 MBytes   332 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   2.00-3.00   sec  8.25 MBytes  69.3 Mbits/sec    0   1.53 MBytes       
[  6]   2.00-3.00   sec  8.12 MBytes  68.3 Mbits/sec    0   1.18 MBytes       
[  8]   2.00-3.00   sec  8.38 MBytes  70.4 Mbits/sec    0   1.36 MBytes       
[ 10]   2.00-3.00   sec  8.62 MBytes  72.5 Mbits/sec    0   1.23 MBytes       
[SUM]   2.00-3.00   sec  33.4 MBytes   281 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   3.00-4.00   sec  11.9 MBytes  99.3 Mbits/sec    0   1.55 MBytes       
[  6]   3.00-4.00   sec  10.6 MBytes  88.8 Mbits/sec    0   1.34 MBytes       
[  8]   3.00-4.00   sec  12.0 MBytes   100 Mbits/sec    0   1.57 MBytes       
[ 10]   3.00-4.00   sec  11.0 MBytes  92.0 Mbits/sec    0   1.42 MBytes       
[SUM]   3.00-4.00   sec  45.5 MBytes   380 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   4.00-5.00   sec  11.1 MBytes  93.7 Mbits/sec    0   1.55 MBytes       
[  6]   4.00-5.00   sec  9.50 MBytes  80.0 Mbits/sec    0   1.34 MBytes       
[  8]   4.00-5.00   sec  11.2 MBytes  94.7 Mbits/sec    0   1.58 MBytes       
[ 10]   4.00-5.00   sec  10.2 MBytes  86.3 Mbits/sec    0   1.42 MBytes       
[SUM]   4.00-5.00   sec  42.1 MBytes   355 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   5.00-6.00   sec  10.9 MBytes  90.9 Mbits/sec    0   1.55 MBytes       
[  6]   5.00-6.00   sec  9.75 MBytes  81.5 Mbits/sec    0   1.34 MBytes       
[  8]   5.00-6.00   sec  11.0 MBytes  91.9 Mbits/sec    0   1.58 MBytes       
[ 10]   5.00-6.00   sec  10.5 MBytes  87.7 Mbits/sec    0   1.43 MBytes       
[SUM]   5.00-6.00   sec  42.1 MBytes   352 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   6.00-7.00   sec  10.9 MBytes  91.5 Mbits/sec    0   1.56 MBytes       
[  6]   6.00-7.00   sec  9.75 MBytes  82.1 Mbits/sec    0   1.35 MBytes       
[  8]   6.00-7.00   sec  11.2 MBytes  94.7 Mbits/sec    0   1.59 MBytes       
[ 10]   6.00-7.00   sec  10.2 MBytes  86.3 Mbits/sec    0   1.43 MBytes       
[SUM]   6.00-7.00   sec  42.1 MBytes   355 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   7.00-8.00   sec  8.88 MBytes  74.4 Mbits/sec    0   1.25 MBytes       
[  6]   7.00-8.00   sec  8.00 MBytes  67.0 Mbits/sec    0   1.12 MBytes       
[  8]   7.00-8.00   sec  9.25 MBytes  77.5 Mbits/sec    0   1.20 MBytes       
[ 10]   7.00-8.00   sec  8.50 MBytes  71.2 Mbits/sec    0   1.14 MBytes       
[SUM]   7.00-8.00   sec  34.6 MBytes   290 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   8.00-9.01   sec  8.75 MBytes  73.2 Mbits/sec    0   1.17 MBytes       
[  6]   8.00-9.01   sec  8.50 MBytes  71.1 Mbits/sec    0   1.08 MBytes       
[  8]   8.00-9.01   sec  8.00 MBytes  66.9 Mbits/sec    0   1.08 MBytes       
[ 10]   8.00-9.01   sec  8.62 MBytes  72.1 Mbits/sec    0   1.13 MBytes       
[SUM]   8.00-9.01   sec  33.9 MBytes   283 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   9.01-10.00  sec  8.38 MBytes  70.5 Mbits/sec    0    863 KBytes       
[  6]   9.01-10.00  sec  7.62 MBytes  64.2 Mbits/sec    0    789 KBytes       
[  8]   9.01-10.00  sec  7.75 MBytes  65.2 Mbits/sec    0    799 KBytes       
[ 10]   9.01-10.00  sec  8.25 MBytes  69.4 Mbits/sec    0    834 KBytes       
[SUM]   9.01-10.00  sec  32.0 MBytes   269 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  4]   0.00-10.00  sec   104 MBytes  87.6 Mbits/sec  862            sender
[  4]   0.00-10.09  sec   104 MBytes  86.0 Mbits/sec                  receiver
[  6]   0.00-10.00  sec  95.4 MBytes  80.0 Mbits/sec  940            sender
[  6]   0.00-10.09  sec  94.5 MBytes  78.6 Mbits/sec                  receiver
[  8]   0.00-10.00  sec   104 MBytes  87.0 Mbits/sec  774            sender
[  8]   0.00-10.09  sec   103 MBytes  85.5 Mbits/sec                  receiver
[ 10]   0.00-10.00  sec  98.0 MBytes  82.2 Mbits/sec  437            sender
[ 10]   0.00-10.09  sec  97.0 MBytes  80.6 Mbits/sec                  receiver
[SUM]   0.00-10.00  sec   402 MBytes   337 Mbits/sec  3013             sender
[SUM]   0.00-10.09  sec   398 MBytes   331 Mbits/sec                  receiver

iperf Done.

=== UDP | 192.168.8.219 ===

Connecting to host 192.168.8.219, port 5201
[  4] local 192.168.8.141 port 55632 connected to 192.168.8.219 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  4]   0.00-1.00   sec  29.8 MBytes   250 Mbits/sec  21583  
[  4]   1.00-2.00   sec  29.9 MBytes   250 Mbits/sec  21687  
[  4]   2.00-3.01   sec  28.4 MBytes   238 Mbits/sec  20561  
[  4]   3.01-4.01   sec  31.2 MBytes   262 Mbits/sec  22603  
[  4]   4.01-5.01   sec  27.4 MBytes   230 Mbits/sec  19875  
[  4]   5.01-6.00   sec  32.1 MBytes   270 Mbits/sec  23255  
[  4]   6.00-7.01   sec  27.0 MBytes   226 Mbits/sec  19557  
[  4]   7.01-8.00   sec  32.5 MBytes   274 Mbits/sec  23532  
[  4]   8.00-9.01   sec  30.0 MBytes   250 Mbits/sec  21689  
[  4]   9.01-10.00  sec  29.7 MBytes   250 Mbits/sec  21479  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  4]   0.00-10.00  sec   298 MBytes   250 Mbits/sec  0.000 ms  0/215821 (0%)  sender
[  4]   0.00-10.07  sec   298 MBytes   248 Mbits/sec  0.059 ms  12/215821 (0.0056%)  receiver

iperf Done.
