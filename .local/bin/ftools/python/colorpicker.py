import sys

MAX=80

def limit(num):
	if num > MAX:
		return MAX
	else:
		return num

h = sys.argv[1].lstrip('#')
values = tuple(int(h[i:i+2], 16) for i in (0, 2, 4))

if sys.argv[2] == "critical":
	print('#%02x%02x%02x' % (255, limit(values[1]), limit(values[2])))
else:
	print('#%02x%02x%02x' % (limit(values[0]), 255, limit(values[2])))
