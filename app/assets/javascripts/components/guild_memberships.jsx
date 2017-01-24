var GuildMemberships = React.createClass({
  getInitialState: function() {
    return {guild_memberships: this.props.guild_memberships};
  },
  render: function() {
    var guildMembers = this.state.guild_memberships.map(function (member) {
      return (
        <GuildMember key={member.id}>
          {member.user_id}
        </GuildMember>
      );
    });

    return (
      <div>
        <h1 className="guild-members-table"> Members </h1>
        {guildMembers}
      </div>
    );
  }
});
