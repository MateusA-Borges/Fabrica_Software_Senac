# main.py
import cv2
import time

#RTSP_URL = "http://admin:Senac@2026@172.17.50.190/cgi-bin/mjpg/video.cgi?channel=1&subtype=1" 
RTSP_URL = 0

# Initialize the camera capture
cap = cv2.VideoCapture(RTSP_URL)

# CRITICAL: Set buffer size to 1 to prevent latency buildup 
# (otherwise, the video will lag further and further behind real-time)
cap.set(cv2.CAP_PROP_BUFFERSIZE, 1) 

last_save_time = 0
save_interval = 10  # Save 1 frame every 10 seconds
i = 0

try:
    while i < 10:
        success, frame = cap.read()
        if not success:
            # If the camera disconnects, wait and retry
            time.sleep(1)
            cap = cv2.VideoCapture(RTSP_URL)
            continue
        
        # # Encode frame as JPEG
        # ret, buffer = cv2.imencode('.jpg', frame, [cv2.IMWRITE_JPEG_QUALITY, 80])
                
        # image = cv2.imdecode(buffer, cv2.IMREAD_COLOR)

        # # 3. Save the image matrix to a file
        # cv2.imwrite(f'output_cam_image_{i}.jpg', image)
        
        # print(f"Saved image {i}")
        
        # time.sleep(5)
        
        current_time = time.time()
        
        # Check if 10 seconds have passed since the last save
        if current_time - last_save_time >= save_interval:
            # Save the frame directly (no need to encode/decode!)
            cv2.imwrite(f'output_cam_image_{i}.jpg', frame)
            print(f"Saved image {i}")
            
            last_save_time = current_time
            i += 1
            
        # Sleep for ~30ms (approx 30 FPS) to drain the buffer without maxing out your CPU
        time.sleep(0.03) 
finally:
    cap.release()

