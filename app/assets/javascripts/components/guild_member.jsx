var GuildMember = React.createClass({
  render: function() {
    return (
      <div className="guild_member">
        <h2> {this.props.author} </h2>

        {this.props.children}
      </div>
    );
  }
});
