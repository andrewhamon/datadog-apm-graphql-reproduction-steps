# Issue

When upgrading from `ddtrace` 0.34.1 to 0.36.0, graphql traces are no longer getting connected to other traces. By not connected, I mean we get the standalone graphl traces, but can't see any db traces nested within them, or parent rack.requst traces. When looking at rack.request traces, we _can_ see the database traces, but no intermediate graphql traces. (Screenshots to follow).

# To reproduce

0) install a datadog agent
1) in a terminal, run the following:
    ```
    rake db:migrate
    rails s
    ```
2) navigate to http://localhost:3000/graphiql
3) execute the following graphql query
    ```
    query testQuery {
      randomWidget {
        id
        name
      }

      widgets(last: 10) {
        edges {
          node {
            id
            name
          }
        }
      }
    }
    ```
4) observe the traces in the datadog app. These are on ddtrace version 0.34.1
5) `git revert 2f838b62a9903d5b8ed43b99286896a8d2fae5ac` to set `ddtrace` to 0.36
6) repeat 1-4, observe that graphql traces are not working correctly

### On version 0.34.1 traces look like this, with graphql traces embedded:
The graphql shows up in the flame chart, with the database queries nested below and wrapped in a parent rack request trace
<img width="2672" alt="Screen Shot 2020-06-02 at 11 09 12 PM" src="https://user-images.githubusercontent.com/5134584/83601917-6af4f480-a526-11ea-8e15-1215de1c9073.png"> 

### On version 0.36, traces look like this... where are the graphql traces?
![image](https://user-images.githubusercontent.com/5134584/83602162-e2c31f00-a526-11ea-9dff-ba02218168e7.png)

### The graphql traces can be found standalone, but they arent connected to their surrounding context (rack restest, database queries):
![image](https://user-images.githubusercontent.com/5134584/83602500-83194380-a527-11ea-8f50-4f66fd849b6c.png)
