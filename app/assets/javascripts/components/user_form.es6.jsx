class ModalUserForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = { errors: [], email: null };
  };

  handleClick(event) {
    if(this.state.email) {
      if(this.validateEmail(this.state.email)) {
        $.ajax({
          type: "POST",
          url: '/users',
          data: {
            user: {
              email: this.state.email
            }
          },
          dataType: "JSON",
          success: (function(newUser, status, response) {
            this.setState({ errors: [], email: null });
            $('#new_user').modal('toggle');
            channelUser.publish('selectUser', newUser);
          }).bind(this),
          error: (function(response, status, exception) {
            this.setState({errors: response.responseJSON.email})
          }).bind(this)
        });
      } else {
        this.setState({errors: ['Email Invalid']})
      }
    } else {
      this.setState({errors: ['Insert Email']})
    }
  };

  validateEmail(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
  };
  
  handleChange(event) {
    this.setState({ email: event.target.value })
  }

  render() {
    var style = 'collapse';
    if (this.state.errors.length > 0) style = '';

    return (
      <div className="modal" id="new_user" style={{display: 'none'}}>
        <div className="modal-dialog">
          <div className="modal-content">
            <div className="form-horizontal">
              <div className="modal-header">
                <button aria-hidden="true" className="close" data-dismiss="modal" type="button"> ×</button>
                <h4 className="modal-title">
                  Create User
                </h4>
              </div>
              <div className="modal-body">
                <br />
                <div className={'alert alert-dismissible alert-danger ' + style}>
                  <ul>
                    {
                      this.state.errors.map(function(error, index) {
                        return (
                          <li>{error}</li>
                        )
                      })
                    }
                  </ul>
                </div>
                <fieldset>
                  <div className="form-group">
                    <label className="col-xs-3 control-label" htmlFor="ticket_issue_type_id">Email</label>
                    <div className="col-xs-9">
                      <input onChange={this.handleChange.bind(this)} className="form-control" value={this.state.email} type="text" name="user[email]" id="user_email" placeholder="john.doe@example.com" />
                    </div>
                  </div>
                </fieldset>
              </div>
              <div className="modal-footer">
                <button className="btn btn-info" data-dismiss="modal" type="button"> Close</button>
                &nbsp;
                <button className="btn btn-primary" type="button" onClick={this.handleClick.bind(this)}>Create</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  };
}
