#!/bin/bash
#
# Copyright 2020 Duckbill Group, LLC
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

INSTANCE_ID=$1
NEW_INSTANCE_TYPE=$2

display_usage() {
  echo "This script shuts down an instance, changes the instance type to the specified, and starts the instance."
  echo "This script requires an instance ID and an instance type"
  echo -e "Usage: ./change_instance_type.sh INSTANCE-ID NEW-INSTANCE-TYPE"
}

change_instance_type() {
  aws ec2 stop-instances --instance-ids "$INSTANCE_ID"
  sleep 120
  echo aws ec2 modify-instance-attribute --instance-id "$INSTANCE_ID" --instance-type "{\"Value\":\"$NEW_INSTANCE_TYPE\"}"
  sleep 10
  echo aws ec2 start-instances --instance-ids "$INSTANCE_ID"
}

if [ $# -le 1 ]
then
  display_usage
  exit 1
fi

change_instance_type
