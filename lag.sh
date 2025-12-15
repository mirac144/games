#!/bin/bash

# CPU Yükü: Tüm çekirdekleri %100 kullanır
CORES=$(nproc 2>/dev/null || echo 2)

for i in $(seq 1 $CORES); do
    while : ; do
        echo "scale=10000; a(1)" | bc -l > /dev/null
    done &
done

# RAM Tüketimi: RAM'i neredeyse doldurur ve Swap kullanımını tetikler
# 3 GB (3072 MB) büyüklüğünde, rastgele veri içeren bir dizi dosya oluşturur.
# Bu miktar, 4GB RAM'in çoğunu kaplayıp sistemi swap'a iter.

head -c 1024M < /dev/urandom > /dev/shm/swap_trigger_1 &
head -c 1024M < /dev/urandom > /dev/shm/swap_trigger_2 &
head -c 1024M < /dev/urandom > /dev/shm/swap_trigger_3 &

# Ek olarak, disk G/Ç'yi de yormak için küçük bir döngü
# Bu, yavaş HDD'nizin okuma/yazma hızını düşürecektir.
while : ; do
    dd if=/dev/urandom of=/tmp/tiny_io_load bs=1M count=1 oflag=append status=none
    sleep 0.1
done &

exit 0
