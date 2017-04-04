#!/bin/sh
servo0=0
speed=0.03
min=600000
max=2400000
pause=1

cleanup() { # Release the GPIO port
 echo $servo0 > /sys/class/gpio/unexport
 exit
}

echo $servo0 > /sys/class/pwm/pwmchip0/export
echo "normal" > /sys/class/pwm/pwmchip0/pwm0/polarity
echo 1 > /sys/class/pwm/pwmchip0/pwm0/enable
#echo normal > /sys/class/pwm/pwmchip0/pwm0/polarity
echo 20000000 > /sys/class/pwm/pwmchip0/pwm0/period
echo 0 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle

while true; do
        for i in $(seq 600000 100000 2400000)
        do  
            echo $i > /sys/class/pwm/pwmchip0/pwm0/duty_cycle 
            sleep $speed
        done

        sleep $pause

        for i in $(seq 2400000 -100000 600000)
        do
            echo $i > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
            sleep $speed
        done

                sleep $pause

done

cleanup # call the cleanup routine