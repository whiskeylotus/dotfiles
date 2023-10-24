#!/bin/bash

# Read input from a file or from user input
# You can change 'input.txt' to the actual input source
input_file=$1

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Input file '$input_file' not found."
    exit 1
fi

echo ".. list-table::"
echo "    :header-rows: 1"
echo "    :width: 100%"
echo ""
echo "    * - Port"
echo "      - Service"
echo "      - Description"

# Read the input file line by line and format the output
grep "tcp" "$input_file" | while IFS= read -r line; do
if [[ $line =~ ^([0-9]+\/tcp)[[:space:]]+open[[:space:]]+([^[:space:]]+)([[:space:]]+(.*))?$ ]]; then
        protocol="${BASH_REMATCH[1]}"
        service="${BASH_REMATCH[2]}"
        description="${BASH_REMATCH[4]:-n/a}"

        # Print the formatted output
        echo "    * - $protocol"
        echo "      - $service"
        echo "      - $description"
    fi
done < "$input_file"

