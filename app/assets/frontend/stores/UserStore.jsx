import AppDispatcher from "../dispatcher";
import ActionTypes from "../constants";
import AppEventEmitter from "./AppEventEmitter";

let _users = [];

class UserEventEmitter extends AppEventEmitter {
  getAll() {
    return _users;
    // .map(user => {
    //   return user;
    // });
  }
}
let UserStore = new UserEventEmitter();

AppDispatcher.register(action => {
  switch(action.actionType) {
    case ActionTypes.RECEIVED_USERS:
      _users = action.rawUsers;
      UserStore.emitChange();
      break;

    default:
      // no operation
  }
});

export default UserStore;