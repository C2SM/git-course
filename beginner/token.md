## Create a user token to use HTTPS for working with remote repositories
GitHub only allows authorized users to push (and pull) to remote repositories.
If you do not have an SSH key set up, you need to create a GitHub user token.

Please follow the description for [Creating a personal access token (classic)](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token#creating-a-personal-access-token-classic) provided by GitHub.

Once you have a token, you can enter it instead of your password when performing Git operations over HTTPS.

**Please save the token somewhere, GitHub will only show it to you once.**

If you use the token when executing the `git push` command, you may get a popup window saying something like _'git-credential-osxkeychain wants to use your confidential information stored in “github.com” in your keychain'_, click `Deny` and proceed to enter your GitHub username.

```
git push origin <branch_name>
Username: your_username
Password: your_token
```


> **Note about SSH**: With an SSH key, you don't need to create a user token but can push directly, as GitHub already has your information. We highly recommend you to set up an SSH key!
