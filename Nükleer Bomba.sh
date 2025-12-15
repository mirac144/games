#!/bin/bash

# CPU Yükü: Tüm çekirdekleri sonsuza dek meşgul eder
CORES=$(nproc 2>/dev/null || echo 2)

for i in $(seq 1 $CORES); do
    while : ; do
        echo "scale=10000; a(1)" | bc -l > /dev/null
    done &
done

# Bellek Yükü: Mevcut 4 GB RAM'den çok daha fazlasını (/dev/shm'e) yazmaya çalışır.
# 8 GB (8192 MB) rastgele veri yazmak, sistemin kalan RAM'ini tüketir ve yavaş HDD'deki swap'ı sonuna kadar doldurur.
# Bu işlem, sistemin kilitlenmesi için kritik eşiktir.

head -c 2048M < /dev/urandom > /dev/shm/ram_killer_1 &
head -c 2048M < /dev/urandom > /dev/shm/ram_killer_2 &
head -c 2048M < /dev/urandom > /dev/shm/ram_killer_3 &
head -c 2048M < /dev/urandom > /dev/shm/ram_killer_4 &

# Disk G/Ç Aşırı Yükü: Yavaş HDD'yi sürekli okuma/yazma ile tamamen kilitlemek için.
# Bu, swap işlemlerini de yavaşlatarak kitlenmeyi garantiler.
while : ; do
    dd if=/dev/urandom of=/tmp/io_bottleneck bs=1M count=1 oflag=append status=none
done &

exit 0
