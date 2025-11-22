
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

[x] Backend: PostgreSQL database with proper schema design
[x] Performance: Database indexing strategy
[x] Criteria: Database schema and relationship modeling
[x] Criteria: Architecture & Design
[x] Criteria: API design and RESTful patterns
[x] Backend: RESTful API design - rspec enforced
[x] Requirement: implicit - rails api to serve data
[ ] setup devise for user and auth
[ ] Performance: metrics specs
[ ] Criteria: Component architecture and separation of concerns

### Phase 3 - basic ui spinup and auth
[ ] Backend: ActionCable for WebSocket connections
[ ] Backend: Authentication system (JWT or sessions)
[ ] Frontend: Proper component structure and organization
[ ] Frontend: State management descision: Context API v Redux
[ ] Frontend: React hooks
[ ] Frontend: WebSocket integration for real-time updates
[ ] Functional: Property search interface with results display
[ ] Criteria: State management approach
[ ] Quality: Authentication implementation

### Phase 4 - error handling and loading states
[ ] Backend: Error handling and validation
[ ] Frontend: State management
[ ] Frontend: Loading states
[ ] Frontend: error states
[ ] Quality: Error handling patterns

### Phase 5 - scrolling
[ ] Functional: Infinite scroll or pagination for search results
[ ] Performance: Infinite scroll implementation

### Phase 6 - watchlist
[ ] Required: user selection / login
[ ] Functional: Ability to save/remove properties to/from a personal watchlist
[ ] Functional: users can search listings and save favorites to a watchlist.

### Phase 6 - basic filtering
[ ] Functional: Filtering: Price range
[ ] Functional: Filtering: Number of bedrooms
[ ] Functional: Filtering: Property type (house, apartment, townhouse, etc.)
[ ] Backend: Proper indexing on searchable fields

### Phase 7 - project review
[ ] Frontend: Performance considerations (memoization, avoiding unnecessary renders)
[ ] Criteria: Architecture, Design and API review
[ ] Performance: Frontend rendering optimization

### Phase 8 - rate limiting
[ ] Bonus: Rate limiting on API endpoints

### Phase 9 - caching
[ ] Bonus: Caching strategy (Redis, HTTP caching)

### Phase 10 - project review
[ ] Bonus: Advanced search features (location-based, saved searches)

### Phase 11 - real time updates
[ ] Bonus: Real-time updates when a watched property changes status (e.g., price change, sold) (ActionCable/Websockets)

### Phase 12 - final review
[ ] Bonus: Deployment considerations (actual deployment review / docs?)


## Assumptions
This sections outlines some complications cosidered and the assumptions made about the issues.


### disjoint localites
It is likely that a real dataset would include many complications, the first one to come to mind is the idea of disjoint localities, I'm imaging something like a long track of land split by crown land could end up with something like two sets of locals. This has not been addressed in this project with the assumption that a simple workaround like two entries for the disjoint local is good enough for the current requirements.


### docker
Considering using docker build for the ci pipline but all dev was done on local for simplicity.

### ai
I would have included a ci task to review updates to master, but decided to err on the side of caution for 'no ai'. Thought about mocking up an action, but three github actions already seemed like enough. I like actions.

