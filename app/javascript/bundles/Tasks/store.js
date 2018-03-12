import { createStore } from redux;
import TasksReducer from '..reducers/Tasks';

const setupStore = (railsProps) => (
  createStore(TasksReducer, railsProps)
);

export default setupStore;