import subprocess
import json
from bs4 import BeautifulSoup

# Get display info
sway_outputs = json.loads(subprocess.check_output(
    ["swaymsg", "-t", "get_outputs"]).decode())
display = sway_outputs[0]  # Adjust for the correct display if multi-monitor
rect = display['rect']
scale = display['scale']

# Screenshot dimensions
# Replace with your screenshot's actual resolution
screenshot_width, screenshot_height = 3840, 2160

# Load the HOCR file
with open('/tmp/output.hocr', 'r') as file:
    soup = BeautifulSoup(file, 'html.parser')

# Target text
target = "https://"  # Replace with the string you're searching for

# Find text and map to absolute coordinates
for span in soup.find_all('span', class_='ocrx_word'):
    text = span.get_text()
    if target.lower() in text.lower():
        title = span['title']
        bbox = title.split('bbox')[1].split(';')[0].strip()
        x1, y1, x2, y2 = map(int, bbox.split())

        # Map to absolute coordinates
        abs_x1 = rect['x'] + (x1 / screenshot_width) * (rect['width'] * scale)
        abs_y1 = rect['y'] + (y1 / screenshot_height) * \
            (rect['height'] * scale)
        abs_x2 = rect['x'] + (x2 / screenshot_width) * (rect['width'] * scale)
        abs_y2 = rect['y'] + (y2 / screenshot_height) * \
            (rect['height'] * scale)

        print(f'Found "{text}" at: ({abs_x1:.1f}, {
              abs_y1:.1f}), ({abs_x2:.1f}, {abs_y2:.1f})')
