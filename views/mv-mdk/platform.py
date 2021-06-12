import time
import serial

# configure the serial connections (the parameters differs on the device you are connecting to)
ser = serial.Serial(
    port='COM29',
    baudrate=115200,
    # parity=serial.PARITY_NONE,
    # stopbits=serial.STOPBITS_ONE,
    # bytesize=serial.EIGHTBITS
)
if ser.isOpen():
    ser.close()
ser.open()
# ser.write('sdfasdfsadf\r\n'.encode())
# ser.close()

# input=1

print("Open Strata or SCI to start platform detection...")
while 1:
    out = ''
    while ser.inWaiting() > 0:
            out += ser.read(1).decode("utf-8") 
    if out != '':
        #print(">>" + out)
        
        if out.find("get_firmware_info") >= 0:
            ser.write('{"ack":"get_firmware_info","payload":{"return_value":true,"return_string":"commandvalid"}}\n'.encode())
            ser.write('{"notification":{"value":"get_firmware_info","payload":{"api_version":"2.0","active":"application","bootloader":{"version":"1.0.0","date":"20180401_123420"},"application":{"version":"1.0.0","date":"20180401_131410"}}}}\n'.encode())
            print("get_firmware_info notification sent")

        if out.find("request_platform_id") >= 0:
            ser.write('{"ack":"request_platform_id","payload":{"return_value":true,"return_string":"commandvalid"}}\n'.encode())
            ser.write('{"notification":{"value":"platform_id","payload":{"name":"MV MDK","controller_type":1,"platform_id":"5a717c84-02f5-42c1-92de-1ec6545b07de","class_id":"5a717c84-02f5-42c1-92de-1ec6545b07de","board_count":1}}}\n'.encode())
            print("request_platform_id notification sent")
            break


while 1 :
    # get keyboard input
    notification = input(">> ")
    if notification == 'exit':
        ser.close()
        exit()
    else:
        # send the character to the device
        # (note that I happend a \r\n carriage return and line feed to the characters - this is requested by my device)
        ser.write((notification + '\n').encode())

    out = ''
    while ser.inWaiting() > 0:
            out += ser.read(1).decode("utf-8") 
    if out != '':
        print(">>" + out)