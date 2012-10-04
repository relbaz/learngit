import json
import sys
b = sys.stdin.read()
print json.dumps(json.loads(b), indent=2)
