## Before You Start
#### Locally

You need to have `sqlite3`, `Ruby 2.7.5`, and `rubygems` installed and working.

#### Docker

In case you do not want to install `ruby` locally and you have already installed `docker` in your
host machine, you can build the exercise image:

```
./script/build
```

And then run a bash container:

```
./script/terminal
```

## Introduction

Razor has a collection of shows with ticket inventory numbers that need to be
synchronized with a 3rd party API located at https://shows-remote-api.com. A
job runs every hour to check which shows need to be synchronized.

When we synchronize shows, we don't want to synchronize them all at once because
we could overwhelm the 3rd party API with web requests. We prefer to schedule the
show updates at least 15 seconds apart, but if there are more shows than can fit
into a 1 hour period spaced 15 seconds apart, the updates can be scheduled in
shorter intervals.

Your job is to examine the shows in the database and determine which ones need to
be updated, then output a hash with the IDs that need updating and when they should
be updated. You will not update any shows as part of this project, only output the
schedule of when each show should be updated. You only need to schedule updates
for shows that exist in your local database, for which the quantity has changed,
and which have not been updated in the last hour.

## Schema With Examples

```
 shows
-------------------------------
| id | quantity | last_update |
|  1 |       35 |         154 |
|  2 |        4 |       10435 |
|  3 |       89 |        7343 |
|  4 |       15 |       12704 |
|  5 |        2 |        3865 |
-------------------------------
```

  * last_update is represented in seconds since last update.

## Example API Interaction

```
GET https://shows-remote-api.com/
```

Response:
```
[
  { "id": 1, "quantity": 34 },
  { "id": 2, "quantity": 4 },
  { "id": 3, "quantity": 91 },
  { "id": 4, "quantity": 12 },
  { "id": 5, "quantity": 1 }
]
```

## Example Output

In our example, we need to update IDs 3, 4, and 5 because it has been more than
an hour since they were last updated and their quantity has changed.

Hash format is { ID => seconds_until_next_update }

```
{ 3 => 0, 4 => 15, 5 => 30 }
```

#### Implementation Details
  * If an ID has never been updated, it will not have a value for seconds_since_last_update
  * You should test at least 2 things for each example file:
    1. Which IDs should be scheduled for update? The outputs for these are included
       in the spec.
    2. When should each ID be scheduled for update? The answer for this is determined
       by you, but should be in the specified format.

#### Other Information
  * Your solution should use Test-Driven Development
  * Feel free to add any gems you may want to use
  * Any resource you want is available. Ask as many questions as you want.
