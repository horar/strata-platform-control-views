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