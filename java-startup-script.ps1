# Sample startup script (PowerShell) to deploy a Java application from a GitHub repository
# Replace the following variables with your GitHub repository details

$githubRepoUrl = "https://github.com/shashirajraja/onlinebookstore.git"
$githubBranch = "main"  # Replace with the desired branch name
$applicationPath = "C:\App"

# Clone the GitHub repository
git clone --single-branch --branch $githubBranch $githubRepoUrl $applicationPath

# Start your Java application (replace 'your-main-class' with the actual main class of your application)
