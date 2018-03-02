import PropTypes from 'prop-types';
import React from 'react';
import Task from './Task';

export default class Tasks extends React.Component {
  constructor(props) {
    super(props);
    this.state = { tasks: [] }
  }

  getTasks() {
    fetch('/api/v1/tasks.json').then(response => {
      return response.json();
    }).then(tasks => {
      this.setState({ tasks: tasks });
    });
  }

  generateList() {
    const tasks = this.state.tasks;
    let taskList = [];

    tasks.forEach((task, i) => {
      taskList.push(<li key={ i }>{ Task(task) }</li>);
    });

    return(
      <ul className="tasks">
        { taskList }
      </ul>
    );
  }

  componentDidMount() {
    this.getTasks();
  }

  render() {
    return(
      <div>
        { this.getTasks.lenth > 0 ? <span>Loading...</span> : this.generateList() }
      </div>
    );
  }
}
