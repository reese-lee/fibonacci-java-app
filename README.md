# Sample Java Application Instrumented with a New Relic APM Agent

This repository contains a simple Java application to calculate the nth number (between 1-90) in the Fibonacci sequence. It has been instrumented with the New Relic Java APM agent.

## To run this application with the New Relic Java agent

* This assumes you have Java and gradle installed on your machine.

1. Clone this repo and `cd` into the root directory.
2. Export your ingest license key:
```shell
export NEW_RELIC_LICENSE_KEY='your_license_key'
```
3. Build and run the app:
```shell
gradle bootRun
```
4. To generate traffic, run:
```shell
./load-generator.sh
```
5. Navigate to your New Relic account to see your data!