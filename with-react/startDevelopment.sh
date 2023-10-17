#!/usr/bin/env bash

# Function to stop both processes
stop_processes() {
  echo "Stopping processes..."
  kill $backend_pid $frontend_pid1 $frontend_pid12 $frontend_pid3
  exit
}

# Start Express.js backend server
echo "Starting Express.js server..."
# cd path/to/your/backend
deno run --allow-env --allow-net api/main.ts &
backend_pid=$!

# Start Create React App frontend
echo "Starting Create React App..."
# cd path/to/your/frontend
deno task dev &
frontend_pid1=$!
frontend_pid2=$(pgrep --full "with-react")
frontend_pid3=$(pgrep --full "npm:vite")


# Set up Ctrl+C handler
trap stop_processes INT

# Keep the script running
wait