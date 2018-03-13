import { connect } from 'react-redux';
import TaskList from '../components/TaskList';

const getVisibleTasks = (tasks, filter) => {
  switch(filter) {
    case 'SHOW_COMPLETE':
      return tasks.filter(t => t.complete);
    case 'SHOW_INCOMPLETE':
      return tasks.filter(t => !t.complete);
    case 'SHOW_ALL':
    default:
      return tasks;
  }
};

const mapStateToProps = (state) => (
  { tasks: getVisibleTasks(state.tasks, state.visible) }
);

const mapDispatchToProps = (dispatch) => (
  {}
);

export default connect(mapStateToProps, mapDispatchToProps)(TaskList);