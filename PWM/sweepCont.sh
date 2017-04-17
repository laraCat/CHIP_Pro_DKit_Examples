#!/bin/sh
servo0=0
speed=2
stopServo=1500000
pause=1

cleanup() { # Release the GPIO port
 echo $servo0 > /sys/class/pwm/pwmchip0/unexport
 exit
}

trap 'cleanup' 2

echo $servo0 > /sys/class/pwm/pwmchip0/export
echo "normal" > /sys/class/pwm/pwmchip0/pwm0/polarity
echo 1 > /sys/class/pwm/pwmchip0/pwm0/enable
echo 20000000 > /sys/class/pwm/pwmchip0/pwm0/period
echo $stopServo > /sys/class/pwm/pwmchip0/pwm0/duty_cycle

while true; do  
                for i in $(seq 1000000 100000 1400000)
        do
                echo $i > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
                echo $i
                sleep $speed
        done

        echo $stopServo > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
        sleep $pause

        for i in $(seq 1600000 100000 2000000)
        do
                echo $i > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
                echo $i
                sleep $speed
        done

        echo $stopServo > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
                sleep $pause

done
