# Introduction
Flutter app, containerized and deployed on OpenShift. CI/CD pipeline for testing, building images and triggering deployments on OpenShift.

## Prerequisites

- Flutter SDK
- Jenkins Server
- OpenShift/Kubernetes Cluster
- PostgreSQL Database

## Getting Started

Explain how to set up and run the project. Provide step-by-step instructions for each component.

### Flutter App

Clone the repository and get Flutter dependencies `flutter pub get`. You can test the app with `flutter run`.

### CI/CD using Jenkins

1. Set up a Jenkins server with the necessary plugins.
2. Create a Jenkins pipeline for your project using the Jenkinsfile in the jenkins directory of this project.
3. Configure Jenkins to trigger the pipeline on code changes or trigger manually.

### OpenShift Deployment

1. Deploy the database using the provided /openshift/database-deployment.yaml file.
2. Deploy the Flutter app using the /openshift/flutter-app-deployment.yaml file.
3. Apply load balancer configurations:

```
kubectl apply -f /openshift/db-lb-service.yaml
kubectl apply -f /openshift/app-lb-service.yaml
```

## Database Configuration Explanation

The SQL script is used to configure a PostgreSQL database with tables, relationships, and initial data. Here's a breakdown of the key elements:

1. Create a New Database

2. **Connect to the Newly Created Database:**
   - It connects to the `my_database` so that subsequent commands are executed within this database context.

3. **Create a 'users' Table:**
   - a table named `users` with columns `id`, `username`, and `email`.
   - The `id` is a serial primary key, ensuring unique identifiers.
   - The `username` and `email` columns are non-null and unique to enforce data integrity.

4. **Create a 'categories' Table:**
   - a table named `categories` with columns `id` and `name`.
   - Similar to the 'users' table, it has a serial primary key and a unique, non-null `name` column.

5. **Create a 'posts' Table:**
   - a table named `posts` with columns `id`, `title`, `content`, `user_id`, and `category_id`.
   - It establishes foreign key relationships (`REFERENCES`) with the 'users' and 'categories' tables.
   - This ensures that `user_id` references a valid user, and `category_id` references a valid category.

6. **Create a 'comments' Table:**
   - a table named `comments` with columns `id`, `text`, `user_id`, `post_id`, and `created_at`.
   - It establishes foreign key relationships with the 'users' and 'posts' tables.
   - Additionally, it includes a `created_at` column with a default timestamp value.

7. **Insert Initial Data:**
   - Subsequent `INSERT INTO` statements add initial data to the 'users', 'categories', 'posts', and 'comments' tables.
   - This data populates the tables with sample values for testing and development purposes.

## Jenkinsfile Explanation

The Jenkinsfile defines the CI/CD pipeline for the Flutter app. It automates the build, security scanning with OWASP ZAP, code analysis with SonarQube, and deployment processes. Here's a breakdown of the key stages and steps:

- **Build Stage:**
  - In this stage, the Flutter app is built for the web using the `flutter build web` command. You can replace this with any Flutter build commands specific to your project.

- **OWASP ZAP Scan Stage:**
  - This stage configures and runs an OWASP ZAP security scan on your Flutter app. Adjust the `zap-cli` command to fit your specific ZAP configuration and scanning needs.

- **SonarQube Analysis Stage:**
  - In this stage, a SonarQube analysis is executed for your project. The `sonar-scanner` command is used with project properties like project key, name, and version. Customize these properties to match your project details.

- **Deploy Stage:**
  - The final stage deploys your Flutter app to the target environment. You should replace `deploy-command-here` with the actual deployment command or script tailored to your deployment process.

- **Post-build Actions:**
  - In the `post` section, you can include any post-build actions or clean-up tasks that should run regardless of the pipeline's outcome.

This Jenkinsfile defines an end-to-end CI/CD pipeline for the Flutter app, encompassing building, security scanning, code analysis, and deployment. Customize the commands and configurations to align with your specific project requirements.

## Integrate OWASP ZAP

OWASP ZAP is a security testing tool used to find vulnerabilities in web applications, including those built with Flutter. To integrate ZAP into your project, follow these steps:

1. Install OWASP ZAP: First, download and install OWASP ZAP from the official website: https://www.zaproxy.org/download/

2. Start ZAP: Launch OWASP ZAP and configure it to proxy your Flutter app's requests. You can set your app's proxy settings to route traffic through ZAP for testing.

3. Scan Your App: Use ZAP's features to scan your Flutter app for security vulnerabilities. ZAP provides various scanning tools to identify issues like SQL injection, XSS, CSRF, etc.

4. Fix Vulnerabilities: Once ZAP identifies vulnerabilities, work on fixing them in your Flutter app's code.

5. Security testing with OWASP ZAP is integrated into te CI/CD pipeline by running scans automatically as part of the build and deploy process.

## Integrate SonarQube

SonarQube is a code quality and security analysis platform. It can help you identify code quality issues, security vulnerabilities, and technical debt in your Flutter app. Here's how to integrate SonarQube:

1. Install SonarQube: Download and install SonarQube on a server or use a cloud-based SonarQube service.

2. Configure Your Project: In your Flutter project, you'll need to configure a sonar-project.properties file to specify project details and SonarQube server information. This project contains a sample in /flutter-app/sonar-project.properties

3. Adjust the properties file as per your needs.

4. Analyze Your Code: Use the sonar-scanner command-line tool or a Jenkins plugin to trigger code analysis and send the results to your SonarQube server.

5. View Results: Access the SonarQube dashboard to see code quality and security reports. It will highlight issues, vulnerabilities, and areas for improvement in your code.

6. Fix Issues: Address the identified issues and vulnerabilities in your Flutter app's code.

You can automatically trigger code analysis on every build to maintain code quality and security over time.

Regularly update your security and code quality analysis tools, since vulnerabilities and best practices change over time. In addition, consider implementing a security review process within your dev or DevOps team to proactively address security concerns.

## LICENSE

This project is licensed under the MIT License. Please see the LICENSE file for more information.
