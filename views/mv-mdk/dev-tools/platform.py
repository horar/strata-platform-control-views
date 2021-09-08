from threading import Thread
import time
import serial

thread_running = True

# configure the serial connections (the parameters differs on the device you are connecting to)
try:
    ser = serial.Serial(
        port='COM5',
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
        if out.find("get_firmware_info") != -1:
            ser.write('{"ack":"get_firmware_info","payload":{"return_value":true,"return_string":"commandvalid"}}\n'.encode())
            ser.write('{"notification":{"value":"get_firmware_info","payload":{"api_version":"2.0","active":"application","bootloader":{"version":"1.0.0","date":"20180401_123420"},"application":{"version":"1.0.0","date":"20180401_131410"}}}}\n'.encode())
            print("\nget_firmware_info notification sent")
            print(">> ", end='', flush=True)
        elif out.find("request_platform_id") != -1:
            ser.write('{"ack":"request_platform_id","payload":{"return_value":true,"return_string":"commandvalid"}}\n'.encode())
            ser.write('{"notification":{"value":"platform_id","payload":{"name":"MV MDK","controller_type":1,"platform_id":"b1133641-5b46-4d11-9b96-9126b9d2a109","class_id":"b1133641-5b46-4d11-9b96-9126b9d2a109","board_count":1}}}\n'.encode())
            print("\nrequest_platform_id notification sent")
            print(">> ", end='', flush=True)
        elif out.find('{"cmd":"run","payload":{"value":1}') != -1:
            actual_speeds = [0, 500, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000]
            board_temps = [0, 23, 30, 40, 44, 50, 66, 77, 88, 90, 95]
            input_voltages = [61.9, 62.1, 60.8, 60.2, 59.7, 60.3, 61.6, 62.4, 60.5, 60.1, 59.0, 60.5]
            ser.write('{"notification":{"value":"status_log","payload":{"value":"Starting motor with 500 RPM/s acceleration"}}}\n'.encode())
            for _ in range(1):
                for (actual_speed, board_temp, input_voltage) in zip(actual_speeds, board_temps, input_voltages):
                    ser.write(('{"notification":{"value":"actual_speed","payload":{"value":' + str(actual_speed) + '}}}\n').encode())
                    ser.write(('{"notification":{"value":"board_temp","payload":{"value":' + str(board_temp) + '}}}\n').encode())
                    ser.write(('{"notification":{"value":"input_voltage","payload":{"value":' + str(input_voltage) + '}}}\n').encode())
                    time.sleep(0.1)
            ser.write('{"notification":{"value":"status_log","payload":{"value":"Motor running at target speed of 5000 RPM"}}}\n'.encode())
            print(">> ", end='', flush=True)
        elif out.find('{"cmd":"run","payload":{"value":0}') != -1:
            ser.write(('{"notification":{"value":"actual_speed","payload":{"value":0}}}\n').encode())
            ser.write(('{"notification":{"value":"board_temp","payload":{"value":23}}}\n').encode())
            ser.write(('{"notification":{"value":"input_voltage","payload":{"value":60}}}\n').encode())
            ser.write('{"notification":{"value":"status_log","payload":{"value":"Motor stopped"}}}\n'.encode())
        elif out.find('control_props') != -1:
            demo_config()
            ser.write('{"notification":{"value":"status_log","payload":{"value":"User interface requested control and parameter values."}}}\n'.encode())
            ser.write(('{"notification":{"value":"request_params", "payload":{}}}\n').encode())
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
        elif (notification == 'demo_config'):
            demo_config()
        elif (notification == 'status_log_fill'):
            ser.write('{"notification":{"value":"status_log","payload":{"value":"aaaaaaaaaaaaaaaaaaaaaaa..."}}}\n'.encode())
            ser.write('{"notification":{"value":"status_log","payload":{"value":"bbbbbbbbbbbbbbbbbbbbbbb..."}}}\n'.encode())
            ser.write('{"notification":{"value":"status_log","payload":{"value":"ccccccccccccccccccccccc..."}}}\n'.encode())
            ser.write('{"notification":{"value":"status_log","payload":{"value":"ddddddddddddddddddddddd..."}}}\n'.encode())
            ser.write('{"notification":{"value":"status_log","payload":{"value":"eeeeeeeeeeeeeeeeeeeeeee..."}}}\n'.encode())
            ser.write('{"notification":{"value":"status_log","payload":{"value":"fffffffffffffffffffffff..."}}}\n'.encode())
            ser.write('{"notification":{"value":"status_log","payload":{"value":"ggggggggggggggggggggggg..."}}}\n'.encode())
            ser.write('{"notification":{"value":"status_log","payload":{"value":"hhhhhhhhhhhhhhhhhhhhhhh..."}}}\n'.encode())
            ser.write('{"notification":{"value":"status_log","payload":{"value":"iiiiiiiiiiiiiiiiiiiiiii..."}}}\n'.encode())
            ser.write('{"notification":{"value":"status_log","payload":{"value":"jjjjjjjjjjjjjjjjjjjjjjj..."}}}\n'.encode())
            ser.write('{"notification":{"value":"status_log","payload":{"value":"kkkkkkkkkkkkkkkkkkkkkkk..."}}}\n'.encode())
            ser.write('{"notification":{"value":"status_log","payload":{"value":"lllllllllllllllllllllll..."}}}\n'.encode())
            ser.write('{"notification":{"value":"status_log","payload":{"value":"mmmmmmmmmmmmmmmmmmmmmmm..."}}}\n'.encode())
            ser.write('{"notification":{"value":"status_log","payload":{"value":"nnnnnnnnnnnnnnnnnnnnnnn..."}}}\n'.encode())
            ser.write('{"notification":{"value":"status_log","payload":{"value":"ooooooooooooooooooooooo..."}}}\n'.encode())
            ser.write('{"notification":{"value":"status_log","payload":{"value":"ppppppppppppppppppppppp..."}}}\n'.encode())
            ser.write('{"notification":{"value":"status_log","payload":{"value":"qqqqqqqqqqqqqqqqqqqqqqq..."}}}\n'.encode())
            ser.write('{"notification":{"value":"status_log","payload":{"value":"rrrrrrrrrrrrrrrrrrrrrrr..."}}}\n'.encode())
        else:
            ser.write((notification + '\n').encode())

def demo_config():
    ser.write('{"notification":{"value":"status_log","payload":{"value":"Configuring user interface configured from firmware..."}}}\n'.encode())
    ser.write('{"notification":{"value":"title","payload":{"caption":"BLDC Motor Drive EVB for 30-60V 1200W Applications"}}}\n'.encode())
    # time.sleep(0.5)
    ser.write('{"notification":{"value":"subtitle","payload":{"caption":"Part of the Motor Development Kit (MDK) Family"}}}\n'.encode())
    # time.sleep(0.5)
    ser.write('{"notification":{"value":"actual_speed","payload":{"caption":"Actual Speed","scales":[10000,0,1000],"states":[1],"value":0.0,"values":[],"unit":"RPM"}}}\n'.encode())
    # time.sleep(0.5)
    ser.write('{"notification":{"value":"target_speed","payload":{"caption":"Target Speed","scales":[5555,55,10],"states":[0],"value":100,"values":[],"unit":"RPM"}}}\n'.encode())
    # time.sleep(0.5)
    ser.write('{"notification":{"value":"acceleration","payload":{"caption":"Acceleration","scales":[1000,0,10],"states":[2],"value":100,"values":[],"unit":"RPM/s"}}}\n'.encode())
    # time.sleep(0.5)
    ser.write('{"notification":{"value":"run","payload":{"caption":"Run","scales":[],"states":[0],"value":0,"values":[],"unit":""}}}\n'.encode())
    # time.sleep(0.5)
    ser.write('{"notification":{"value":"brake","payload":{"caption":"Brake","scales":[],"states":[2],"value":0,"values":[],"unit":""}}}\n'.encode())
    # time.sleep(0.5)
    ser.write('{"notification":{"value":"direction","payload":{"caption":"Direction","scales":[],"states":[0],"value":1,"values":[],"unit":""}}}\n'.encode())
    # time.sleep(0.5)
    ser.write('{"notification":{"value":"board_temp","payload":{"caption":"MOSFET Temp","scales":[140,0,10],"states":[1],"value":0.0,"values":[],"unit":"C"}}}\n'.encode())
    # time.sleep(0.5)
    ser.write('{"notification":{"value":"input_voltage","payload":{"caption":"Input Voltage","scales":[100,0,10],"states":[1],"value":0.0,"values":[],"unit":"V"}}}\n'.encode())
    # time.sleep(0.5)
    ser.write('{"notification":{"value":"warning_1","payload":{"caption":"OCP","scales":[],"states":[1],"value":false,"values":[],"unit":""}}}\n'.encode())
    # time.sleep(0.5)
    ser.write('{"notification":{"value":"warning_2","payload":{"caption":"OTP","scales":[],"states":[1],"value":false,"values":[],"unit":""}}}\n'.encode())
    # time.sleep(0.5)
    ser.write('{"notification":{"value":"warning_3","payload":{"caption":"OVP","scales":[],"states":[1],"value":false,"values":[],"unit":""}}}\n'.encode())
    # time.sleep(0.5)
    ser.write('{"notification":{"value":"warning_4","payload":{"caption":"???","scales":[],"states":[1],"value":false,"values":[],"unit":""}}}\n'.encode())
    # time.sleep(0.5)
    ser.write('{"notification":{"value":"status_log","payload":{"value":"Done!"}}}\n'.encode())

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