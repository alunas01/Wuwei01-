# Goal Setting Web UI - Multi-Agent System

A modern, easy-to-use web interface for managing goals and coordinating quantum multi-agent system execution.

## Features

✨ **Goal Management**
- Create, edit, delete goals
- Set priorities (low, medium, high)
- Categorize goals (general, quantum, ML, optimization, analysis)
- Define deadlines and progress tracking
- Assign multiple agents per goal

📊 **Real-time Statistics**
- Total goals count
- Active, executing, and completed goal tracking
- Average progress monitoring
- Live updates every 10 seconds

🤖 **Agent Coordination**
- Assign quantum agents, ML agents, optimizers, and data agents
- Execute goals with assigned agents
- Track execution history
- Monitor agent performance

🎨 **Modern UI**
- Responsive design (desktop and mobile)
- Dark gradient theme
- Smooth animations and transitions
- Intuitive controls

## Quick Start

### 1. Install Dependencies

```bash
pip install -r Requirements.txt
```

Or just Flask:

```bash
pip install Flask==3.0.0 Werkzeug==3.0.1
```

### 2. Run the Web UI

```bash
python app.py
```

The app will start on `http://localhost:5000`

### 3. Open in Browser

Navigate to [http://localhost:5000](http://localhost:5000)

## Usage

### Create a Goal

1. Fill in the goal title (required)
2. Add a description (optional)
3. Set priority level (low/medium/high)
4. Choose a category
5. Set a deadline (optional)
6. Select which agents to assign
7. Click "Create Goal"

### Manage Goals

- **Execute**: Start the goal with assigned agents
- **Edit**: Modify goal details (coming soon)
- **Delete**: Remove a goal permanently

### Monitor Progress

- View real-time statistics on the right panel
- Check average progress bar
- See goal status (active/executing/completed)
- Review execution history

## API Reference

### Endpoints

#### Get all goals
```bash
GET /api/goals
```

#### Create a goal
```bash
POST /api/goals
Content-Type: application/json

{
  "title": "Optimize quantum circuit",
  "description": "Fine-tune the circuit depth and fidelity",
  "priority": "high",
  "category": "quantum",
  "deadline": "2026-02-28",
  "agents_assigned": ["quantum_agent", "optimizer_agent"],
  "tasks": []
}
```

#### Get specific goal
```bash
GET /api/goals/<goal_id>
```

#### Update a goal
```bash
PUT /api/goals/<goal_id>
Content-Type: application/json

{
  "status": "completed",
  "progress": 100
}
```

#### Delete a goal
```bash
DELETE /api/goals/<goal_id>
```

#### Execute a goal
```bash
POST /api/goals/<goal_id>/execute
```

#### Get statistics
```bash
GET /api/stats
```

#### Get execution history
```bash
GET /api/history
```

## Data Storage

Goals are stored in `goals.json` in the working directory:

```json
{
  "goals": [
    {
      "id": 1707081234.567,
      "title": "Goal name",
      "description": "Goal description",
      "priority": "high",
      "category": "quantum",
      "status": "active",
      "created_at": "2026-02-05T...",
      "deadline": "2026-02-28",
      "agents_assigned": ["quantum_agent"],
      "tasks": [],
      "progress": 50
    }
  ],
  "history": [
    {
      "goal_id": "1707081234.567",
      "goal_title": "Goal name",
      "agents": ["quantum_agent"],
      "timestamp": "2026-02-05T...",
      "status": "started"
    }
  ]
}
```

## Integration with Your Agents

To integrate with your existing quantum multi-agent system:

1. **Import in your agent code**:
   ```python
   import requests
   
   # Fetch goals for an agent
   response = requests.get('http://localhost:5000/api/goals')
   goals = response.json()
   
   # Filter by agent name
   my_goals = [g for g in goals if 'quantum_agent' in g['agents_assigned']]
   ```

2. **Update progress**:
   ```python
   requests.put(f'http://localhost:5000/api/goals/{goal_id}', json={
       'progress': 75,
       'status': 'executing'
   })
   ```

3. **Mark as complete**:
   ```python
   requests.put(f'http://localhost:5000/api/goals/{goal_id}', json={
       'status': 'completed',
       'progress': 100
   })
   ```

## Customization

### Adding More Agents

Edit `templates/index.html` in the agent selector section:

```html
<div class="agent-checkbox">
    <input type="checkbox" id="agent5" value="your_new_agent">
    <label for="agent5">Your New Agent</label>
</div>
```

### Changing the Port

Edit `app.py`:

```python
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=8000)  # Change port here
```

### Adding More Categories

Edit `templates/index.html` in the category select:

```html
<option value="your_category">Your Category</option>
```

## Project Structure

```
/workspaces/Wuwei01/
├── app.py                 # Flask backend
├── templates/
│   └── index.html        # Web UI
├── goals.json            # Data storage (auto-created)
└── Requirements.txt      # Python dependencies
```

## Troubleshooting

**Port already in use?**
```bash
# Find process using port 5000
lsof -i :5000

# Kill it
kill -9 <PID>
```

**No goals showing?**
- Click "Refresh Stats" button
- Check that `goals.json` exists in current directory
- Clear browser cache (Ctrl+Shift+Del)

**API requests failing?**
- Ensure Flask app is running: `python app.py`
- Check console for error messages
- Verify correct API endpoint in browser network tab

## Future Enhancements

- [ ] Goal editing UI
- [ ] Advanced filtering and search
- [ ] Real-time agent status dashboard
- [ ] Goal templates
- [ ] Team collaboration features
- [ ] Export/import goals
- [ ] Advanced analytics
- [ ] Goal dependencies and sub-tasks
- [ ] Notifications and alerts

## License

Your project license here

## Support

For issues or questions, check your agent documentation or project README.
