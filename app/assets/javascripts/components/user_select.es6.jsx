class UserSelect extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      users: props.users,
      _selected: props.users[0]
    };

    channelUser = new EventBroker;
    channelUser.create('selectUser');
    channelUser.subscribe('selectUser', (function(newUser) {
      this.state.users.unshift(newUser)
      this.setState({
        users: this.state.users,
        _selected: newUser.id
      });
    }).bind(this));
  }

  componentDidUpdate() {
    $('.chosen-select').trigger("chosen:updated");
  }

  handleChange() {}

  render() {
    return (
      <select value={this.state._selected} onChange={this.handleChange} className={this.props.klass} name={this.props.model + '[' + this.props.attr + ']'} id={this.props.model + '_' + this.props.attr}>
        {
          this.state.users.map(function(user, index) {
            return (<option key={'user-options' + index} value={user.id}>{user.email}</option>)
          })
        }
      </select>
    );
  };
}

UserSelect.propTypes = {
  users: React.PropTypes.array,
  model: React.PropTypes.string,
  attr: React.PropTypes.string,
  klass: React.PropTypes.string
};
