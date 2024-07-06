#!/bin/bash

# Get the current value of map_max_count
current_value=$(sysctl -n vm.max_map_count)

# Check if the current value is less than 655300
if [ "$current_value" -lt 655300 ]; then
    echo "Adjusting vm.max_map_count to 655300"
    sudo sysctl -w vm.max_map_count=655300
else
    echo "vm.max_map_count is already sufficient: $current_value"
fi


