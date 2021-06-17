from threading import Thread
import time
import serial

thread_running = True

# configure the serial connections (the parameters differs on the device you are connecting to)
try:
    ser = serial.Serial(
        port='COM29',
        baudrate=115200,
        timeout=1
    )
except PermissionError or serial.serialutil.SerialException:
    ser.close()
    ser.open()
except:
    print("Serial port could not be opened!")
    exit()

# constantly read serial port waiting for commands
def read_serial():
    global thread_running
    while thread_running:
        out = ''
        while ser.inWaiting() > 0:
            out += ser.read(1).decode("utf-8") 
        if out.find("get_firmware_info") >= 0:
            ser.write('{"ack":"get_firmware_info","payload":{"return_value":true,"return_string":"commandvalid"}}\n'.encode())
            ser.write('{"notification":{"value":"get_firmware_info","payload":{"api_version":"2.0","active":"application","bootloader":{"version":"1.0.0","date":"20180401_123420"},"application":{"version":"1.0.0","date":"20180401_131410"}}}}\n'.encode())
            print("\nget_firmware_info notification sent")
            print(">> ", end='', flush=True)
        elif out.find("request_platform_id") >= 0:
            ser.write('{"ack":"request_platform_id","payload":{"return_value":true,"return_string":"commandvalid"}}\n'.encode())
            ser.write('{"notification":{"value":"platform_id","payload":{"name":"MV MDK","controller_type":1,"platform_id":"5a717c84-02f5-42c1-92de-1ec6545b07de","class_id":"5a717c84-02f5-42c1-92de-1ec6545b07de","board_count":1}}}\n'.encode())
            print("\nrequest_platform_id notification sent")
            print(">> ", end='', flush=True)
        elif out.find("{\"cmd\":\"run\",\"payload\":{\"value\":1}") != -1:
            actual_speeds = [0, 500, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000]
            board_temps = [0, 23, 30, 40, 44, 50, 66, 77, 88, 90, 95]
            input_voltages = [61, 62, 60, 60, 59, 60, 61, 62, 60, 60, 59, 60]
            ser.write('{"notification":{"value":"status_log","payload":{"value":"Starting motor with 500 RPM/s acceleration"}}}\n'.encode())
            for _ in range(1):
                for (actual_speed, board_temp, input_voltage) in zip(actual_speeds, board_temps, input_voltages):
                    ser.write(('{"notification":{"value":"actual_speed","payload":{"value":' + str(actual_speed) + '}}}\n').encode())
                    ser.write(('{"notification":{"value":"board_temp","payload":{"value":' + str(board_temp) + '}}}\n').encode())
                    ser.write(('{"notification":{"value":"input_voltage","payload":{"value":' + str(input_voltage) + '}}}\n').encode())
                    time.sleep(1)
            ser.write('{"notification":{"value":"status_log","payload":{"value":"Motor running at target speed of 5000 RPM"}}}\n'.encode())
            print(">> ", end='', flush=True)
        elif out.find("{\"cmd\":\"run\",\"payload\":{\"value\":0}") != -1:
            ser.write(('{"notification":{"value":"actual_speed","payload":{"value":0}}}\n').encode())
            ser.write(('{"notification":{"value":"board_temp","payload":{"value":23}}}\n').encode())
            ser.write(('{"notification":{"value":"input_voltage","payload":{"value":60}}}\n').encode())
            ser.write('{"notification":{"value":"status_log","payload":{"value":"Motor stopped"}}}\n'.encode())
        elif out != '':
            print("\ncommand: " + out, end='')
            print(">> ", end='', flush=True)

# wait for notification 
def take_input():
    global thread_running
    while 1:
        notification = input(">> ")
        if notification == 'exit':
            thread_running = False
            return
        elif notification == 'demo_config':
            ser.write('{"notification":{"value":"status_log","payload":{"value":"Configuring user interface configured from firmware..."}}}\n'.encode())
            ser.write('{"notification":{"value":"title","payload":{"caption":"BLDC Motor Drive EVB for 30-60V 1200W Applications"}}}\n'.encode())
            time.sleep(0.5)
            ser.write('{"notification":{"value":"subtitle","payload":{"caption":"Part of the Motor Development Kit (MDK) Family"}}}\n'.encode())
            time.sleep(0.5)
            ser.write('{"notification":{"value":"actual_speed","payload":{"caption":"Actual Speed","scales":[10000,0,1000],"states":[1],"value":0.0,"values":[],"unit":"RPM"}}}\n'.encode())
            time.sleep(0.5)
            ser.write('{"notification":{"value":"target_speed","payload":{"caption":"Target Speed","scales":[10000,0,10],"states":[0],"value":5000,"values":[],"unit":"RPM"}}}\n'.encode())
            time.sleep(0.5)
            ser.write('{"notification":{"value":"acceleration","payload":{"states":[1]}}}\n'.encode())
            time.sleep(0.5)
            ser.write('{"notification":{"value":"brake","payload":{"states":[2]}}}\n'.encode())
            time.sleep(0.5)
            ser.write('{"notification":{"value":"board_temp","payload":{"caption":"MOSFET Temp","scales":[140,0,10],"states":[1],"value":0.0,"values":[],"unit":"C"}}}\n'.encode())
            time.sleep(0.5)
            ser.write('{"notification":{"value":"input_voltage","payload":{"caption":"Input Voltage","scales":[100,0,10],"states":[1],"value":0.0,"values":[],"unit":"V"}}}\n'.encode())
            time.sleep(0.5)
            ser.write('{"notification":{"value":"warning_1","payload":{"caption":"OCP","scales":[],"states":[1],"value":false,"values":[],"unit":""}}}\n'.encode())
            time.sleep(0.5)
            ser.write('{"notification":{"value":"warning_2","payload":{"caption":"OTP","scales":[],"states":[1],"value":false,"values":[],"unit":""}}}\n'.encode())
            time.sleep(0.5)
            ser.write('{"notification":{"value":"warning_3","payload":{"caption":"OVP","scales":[],"states":[1],"value":false,"values":[],"unit":""}}}\n'.encode())
            time.sleep(0.5)
            ser.write('{"notification":{"value":"status_log","payload":{"value":"Done!"}}}\n'.encode())

        else:
            ser.write((notification + '\n').encode())

if __name__ == '__main__':
    t1 = Thread(target=read_serial)
    t2 = Thread(target=take_input)

    t1.start()
    t2.start()

    print("Open Strata or SCI to start platform detection...")

    t2.join() # waits until user type
    thread_running = False
    ser.close()
    exit()