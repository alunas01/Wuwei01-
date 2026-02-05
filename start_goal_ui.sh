#!/usr/bin/env bash
# Goal Setting Web UI - Control Script
# Usage: start_goal_ui.sh [start|stop|restart|status|logs]

set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

LOG_FILE="/tmp/goal_ui.log"
PID_FILE="/tmp/goal_ui.pid"
APP_CMD="python3 app.py"

ensure_python_and_flask() {
    if ! command -v python3 &> /dev/null; then
        echo "❌ Python 3 is not installed"
        exit 1
    fi
    if ! python3 -c "import flask" 2>/dev/null; then
        echo "📦 Installing Flask and Werkzeug..."
        pip install Flask==3.0.0 Werkzeug==3.0.1
    fi
}

start() {
    ensure_python_and_flask
    if pgrep -f "app.py" > /dev/null; then
        echo "⚠️  app.py already running"
        status
        return
    fi
    echo "🚀 Starting Goal Setting Web UI..."
    nohup $APP_CMD > "$LOG_FILE" 2>&1 &
    echo $! > "$PID_FILE"
    sleep 0.5
    echo "📍 Server URL: http://127.0.0.1:5000"
    echo "🔍 Logs: tail -f $LOG_FILE" 
}

stop() {
    if [ -f "$PID_FILE" ]; then
        PID=$(cat "$PID_FILE")
        if kill -0 "$PID" 2>/dev/null; then
            echo "🛑 Stopping PID $PID"
            kill "$PID"
            rm -f "$PID_FILE"
            return
        fi
    fi
    # fallback: kill by name
    if pgrep -f "app.py" > /dev/null; then
        echo "🛑 Stopping app.py by process name"
        pkill -f "app.py" || true
        rm -f "$PID_FILE" || true
        return
    fi
    echo "ℹ️  No running app found"
}

status() {
    if [ -f "$PID_FILE" ]; then
        PID=$(cat "$PID_FILE")
        if kill -0 "$PID" 2>/dev/null; then
            echo "✅ Running (PID $PID)"
            return
        fi
    fi
    if pgrep -f "app.py" > /dev/null; then
        echo "✅ Running (found by name)"
        pgrep -af "app.py"
        return
    fi
    echo "❌ Not running"
}

logs() {
    if [ -f "$LOG_FILE" ]; then
        tail -n 200 "$LOG_FILE"
    else
        echo "No log file found at $LOG_FILE"
    fi
}

case "${1:-start}" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop || true
        start
        ;;
    status)
        status
        ;;
    logs)
        logs
        ;;
    *)
        echo "Usage: $0 [start|stop|restart|status|logs]"
        exit 2
        ;;
esac

exit 0
