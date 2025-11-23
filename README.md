
# LandWatcher
A simple property listing with searching and saving

## Tool versions
Would be nice to have test builds of a couple of other ruby versions in ci but just sticking with a single version for simplicity.
ruby 3.4.4
Rails 8.1.1
npm 9.2.0
npx 11.3.0
yarn 1.22.22
PostgreSQL 17.6


## Running LandWatcher
Assuming the dependancies from tool versions are setup running the project should be pretty simple.
Setup:
* `git clone ...`
* `bundle install`
* update `config/database.yml` with your username and password
* `rails db:create db:migrate db:seed`
* `./bin/rubocop`
* `./bin/brakeman`
* `./bin/bundler-audit`
* `bundle exec rspec` or `rake`
* `yarn --cwd client install`
* `yarn --cwd client test`
* `yarn --cwd client build` # not required for dev

Run the Project:
* `rails server --port 3001`
* `yarn --cwd client dev`
or with foreman
* `foreman start`

test api is up:
* `curl localhost:3001/properties`


## Plan Breakdown and Checklist

### Phase 1 - setup and infra
This section would normaly be kept in a notes file apart from the repository, but is included here for your consideration. I have taken the requirements, categorized and prioritized the tasks and requirements.

Some items may span phases and move around as the project progresses and uncompleted checklist items generally chagne over time as the project progresses and the requirements crystalize. Life and software are both a bit messy.

All specs and test are run by ci on all commits to surface issues as soon as possible. Jest setup took longer than expected, but it is the first time setting up ci and deployment for React so not that surprising i suppose. Render deployment also configured to run on all commits to master, unfortunatly deployment only shows an empty page which i won't trouble shoot right now, but it at least exercises and verifies the deployment for the time being.

Hopefully the longest part of the project, getting everything setup with running ci to ensure independant builds and tests. Would have been nice to add docker builds to the pipeline, but left out for berevity as they are not used in deployment.

One of the best bits of `bullet` is getting live feedback in rails. I susspect without further tweaking this won't be passed through to react, i won't fiddle with this now but would find a way to surface it if the project was ongoing.

[x] Backend: Ruby on Rails
[x] Requirement: public GitHub repo
[x] Backend: RSpec tests for critical paths - gh actions ci pipeline
[x] Frontend: Modern React
[x] Frontend: Jest/React Testing Library tests
[x] Quality: Testing approach and coverage - gh actions automations
[x] Bonus: Deployment considerations (Docker, environment config) - early calls - mock docker build?
[-] Requirement: no ai - mock ai review action
[x] Performance: Query optimization (avoiding N+1 queries) - bullet
[x] Quality: Code organization and readability - documentation and cleanup of unused components

### Phase 2 - design and db spike

Required Tables and Fields:
properties
  - title/name: implied by search - string
  - description: implied by search - text
  - price: implied by filtering - integer cents - money gem overkill?
  - bedrooms: implied by filtering
    - int field - seems too specific - what about bathrooms next week
    - has many sub-type: rooms? - overkill?
    - json list of rooms? - akward?
  - type: implied by filtering
    - enum?

realisticly the types of rooms that would be counted would be both finite and small, so maybe in fields for bedrooms, bathrooms, garage spots would be fine. since the problem does not imply enough context to determine if the requirement will likely change i'll probaly just add an int field.

similarly with type, in a real world scenario there could be sub-types or room counts dependant on type (don't list the number of bowling lanes if the type isn't mansion). but again as specified i think an int backed enum would do the job for the project as stated.

although with a simplified single table structure it's hard to avoid n+1 queries... am i missing something? maybe take the complex room structure for the sake of another table?

Also, How can I separate concerns if ther is only a single model? even if i break out the room types into a second model there is not really going to be much concern to break out. I'm kind of struggling how to demonstrate how to demonstrate good design and relationship modeling on such a simple setup. Maybe some of it refers to the react components, but n+1 queries are explicitly called out.

Adding in Users and Watchlist adds some complexity I suppose. The interface for user switching is never mentioned, but implies the existance of a users table, and watchlist will be a many to many relation between users and properties, ok, some room for n+1 queries there. Alternativly the watchlist could be stored similar to tags as a string of identifiers in a text/json field on the user model, on a large enough set of users and properties this could be more efficient than filtering a whole table for the watchlist and also introduce isolation between users data.

So we end up with something like:

Property:
  - title - string - index for search
  - description: - text - index for search
  - price: integer cents - index for filter
  - bedrooms: int - index for filter
  - type: int enum - index for filter

User:
  - name - string
  - email - string - devise
  - password... - string - devise

Watch
  - user - relation - index for watchlist
  - property - relation

Setting up devise turned out to be more difficult with the api only rails setup as it assumes a lot of views and workflows, hope that wasn't a mistake. I'd also normally add in something like flamegraph for metrics on performance, but again, normally done through the rails views and i don't want to waste time trying to thread it through to react for the poc. As a standin I have created a simple benchmark on creating, viewing and destroying a property 1000 times and including the result in the rspec output. idealy this could be pulled out and reasonable threasholds could be checked in ci. So our starting point for performance is:
```
   User       System     Total        Real (seconds)
  2.875455   0.159108   3.034563 (  3.035420)
```

[x] Backend: PostgreSQL database with proper schema design
[x] Performance: Database indexing strategy
[x] Criteria: Database schema and relationship modeling
[x] Criteria: Architecture & Design
[x] Criteria: API design and RESTful patterns
[x] Backend: RESTful API design - rspec enforced
[x] Requirement: implicit - rails api to serve data
[x] setup devise for user and auth
[x] Performance: metrics specs

### Phase 3 - basic ui spinup and auth

I have used action cable before to provide live updates to rails views, but am unsure how they fit in with the React frontend. Perhaps it could be used to provide live updates to react in a similar way, but how does that fit with react requesting the data and doing dynamic updates, i'm pushing it back until there is a ui to update.

Mocked up a basic UI in react, some room for improvment in the way the tools overlay the results, but good enought for a poc. Should be simple to move the tools above the listings as the screen narrows into a mobile display, but transitioning from a list to something like cards would also be nice to have.

Threading the listing through to the frontend seems like a logical place to start with react hooks, simple proof of concept to list all properties done. Day one down and still five phases to go, striking out any optional or streatch goals and start on authentication tomorrow. Still unsure about how to thread the user through from an api only app without something like a 'current user' api, maybe break with the api-only model for devise or something. Had an idea over dinner to show a login form in the nav bar, fingers crossed react has a session cookie or something similar i could bundle in with that and send rails a request like: this user, with this password, wants to auth this session cookie. then rails could do the auth and signal back that x session is authorized by x user. Logout would then just be react forgetting or refreshing the session.

Looking like Devise might not be the optimal solution for rails in api mode, does not seem to like json requests and getting format errors. This seems to be forcing me down the JWT path as the only option, probably a better long term solution but not my preffered option for a 'quick project'. JWT setup on rails was reasonably painless, got react pulling login data from a form and calling the rails login api and saving it to local store unfortunatly i'm not seeing the authorization header despite getting 200 for a good email/password and 401 otherwise. Not sure how far to chase this, maybe just make a ui change based on the 200 and get on with the project. Well it seems I'm tripping over all the React newbie traps, I've tried to just set a local storage setting to color the login area based on the last login attempt, but for the life of me I can't get it to update the component without a page refresh. Even updating the login components contents do not trigger the color change. Well it's taken half of day two to fail to get the user auth working and theres still another planned phase before getting around to the first user facing feature, this feels like it's been going badly. I'm going to skip ahead a try and get a feature or two done before I run out of time completly.

[x] Functional: Property search interface with results display
[x] Frontend: Proper component structure and organization
[x] Frontend: React hooks
[x] Backend: login fields and current user in navbar
[x] Backend: Authentication system (JWT or sessions)
[x] Frontend: State management descision: Context API v Redux
[?] Criteria: State management approach
[-] Quality: Authentication implementation
[?] Criteria: Component architecture and separation of concerns
[-] Frontend: WebSocket integration for real-time updates
[-] Backend: ActionCable for WebSocket connections

### Phase 4 - error handling and loading states
[-] Backend: Error handling and validation
[-] Frontend: State management
[-] Frontend: Loading states
[-] Frontend: error states
[-] Quality: Error handling patterns

### Phase 5 - scrolling
ok tankfully things are starting to move in the right direction. unfortunatly the infinate scroll library selected does not
handle splitting the table after the header, so the header scrolls off the top of the page. switching over to flex divs
would be optimal, but not on the agenda since time is running short. Functional is good enough to progress.

Next feature would have been the watch list, but i'll flip the order as filtering and serarching don't require accounts.

[x] Functional: Infinite scroll or pagination for search results
[x] Performance: Infinite scroll implementation

### Phase 6 - basic filtering
[ ] Functional: Filtering: Price range
[ ] Functional: Filtering: Number of bedrooms
[ ] Functional: Filtering: Property type (house, apartment, townhouse, etc.)
[ ] Backend: Proper indexing on searchable fields

### Phase 7 - watchlist
[ ] Required: user selection / login
[ ] Functional: Ability to save/remove properties to/from a personal watchlist
[ ] Functional: users can search listings and save favorites to a watchlist.

### Phase 8 - project review
[ ] revisit login ui
[ ] revisit docker for render deployment
[ ] Frontend: Performance considerations (memoization, avoiding unnecessary renders)
[ ] Criteria: Architecture, Design and API review
[ ] Performance: Frontend rendering optimization

### Phase 9 - rate limiting
[-] Bonus: Rate limiting on API endpoints

### Phase 10 - caching
[-] Bonus: Caching strategy (Redis, HTTP caching)

### Phase 11 - project review
[-] Bonus: Advanced search features (location-based, saved searches)

### Phase 12 - real time updates
[-] Bonus: Real-time updates when a watched property changes status (e.g., price change, sold) (ActionCable/Websockets)

### Phase 13 - final review
[-] Bonus: Deployment considerations (actual deployment review / docs?)

### Phase 14 - other nice to haves
[-] react layout transitions to vertical as screen shrinks and it overlays listing
[-] listing transitions to card layout at mobile widths
[-] maybe card first listing might have worked toos

## Assumptions
This sections outlines some complications cosidered and the assumptions made about the issues.


### disjoint localites
It is likely that a real dataset would include many complications, the first one to come to mind is the idea of disjoint localities, I'm imaging something like a long track of land split by crown land could end up with something like two sets of locals. This has not been addressed in this project with the assumption that a simple workaround like two entries for the disjoint local is good enough for the current requirements.


### docker
Considering using docker build for the ci pipline but all dev was done on local for simplicity.

### ai
I would have included a ci task to review updates to master, but decided to err on the side of caution for 'no ai'. Thought about mocking up an action, but three github actions already seemed like enough. I like actions.

