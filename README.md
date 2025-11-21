
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
* update `config/database.yml` with your username and password
* `bundle install`

Run the Project:
* `rails server`


## Plan Breakdown and Checklist
This section would normaly be kept in a notes file apart from the repository, but is included here for your consideration. I have taken the requirements, categorized and prioritized the tasks and requirements.

Some items may span phases and move around as the project progresses and uncompleted checklist items generally chagne over time as the project progresses and the requirements crystalize. Life and software are both a bit messy.

Phase 1 - setup and infra
[x] Backend: Ruby on Rails
[ ] Requirement: public GitHub repo
[ ] Backend: RSpec tests for critical paths
[ ] Frontend: Modern React
[ ] Frontend: Jest/React Testing Library tests
[ ] Quality: Testing approach and coverage - gh actions automations
[ ] Bonus: Deployment considerations (Docker, environment config) - early calls - mock docker build?
[ ] Requirement: no ai - mock ai review action
[ ] Performance: Query optimization (avoiding N+1 queries) - bullet - metrics specs
[ ] Quality: Code organization and readability

Phase 2 - design and db spike
[ ] Backend: RESTful API design
[ ] Backend: PostgreSQL database with proper schema design
[ ] Frontend: State management descision: Context API v Redux
[ ] Frontend: Proper component structure and organization
[ ] Criteria: Architecture & Design
[ ] Criteria: API design and RESTful patterns
[ ] Criteria: Database schema and relationship modeling
[ ] Criteria: Component architecture and separation of concerns
[ ] Performance: Database indexing strategy

Phase 3 - basic ui spinup and auth
[ ] Backend: ActionCable for WebSocket connections
[ ] Backend: Authentication system (JWT or sessions)
[ ] Frontend: React hooks
[ ] Frontend: WebSocket integration for real-time updates
[ ] Functional: Property search interface with results display
[ ] Criteria: State management approach
[ ] Quality: Authentication implementation

Phase 4 - error handling and loading states
[ ] Backend: Error handling and validation
[ ] Frontend: State management
[ ] Frontend: Loading states
[ ] Frontend: error states
[ ] Quality: Error handling patterns

Phase 5 - scrolling
[ ] Functional: Infinite scroll or pagination for search results
[ ] Performance: Infinite scroll implementation

Phase 6 - watchlist
[ ] Functional: Ability to save/remove properties to/from a personal watchlist
[ ] Functional: users can search listings and save favorites to a watchlist.

Phase 6 - basic filtering
[ ] Functional: Filtering: Price range
[ ] Functional: Filtering: Number of bedrooms
[ ] Functional: Filtering: Property type (house, apartment, townhouse, etc.)
[ ] Backend: Proper indexing on searchable fields

Phase 7 - project review
[ ] Frontend: Performance considerations (memoization, avoiding unnecessary renders)
[ ] Criteria: Architecture, Design and API review
[ ] Performance: Frontend rendering optimization

Phase 8 - rate limiting
[ ] Bonus: Rate limiting on API endpoints

Phase 9 - caching
[ ] Bonus: Caching strategy (Redis, HTTP caching)

Phase 10 - project review
[ ] Bonus: Advanced search features (location-based, saved searches)

Phase 11 - real time updates
[ ] Bonus: Real-time updates when a watched property changes status (e.g., price change, sold) (ActionCable/Websockets)

Phase 12 - final review
[ ] Bonus: Deployment considerations (actual deployment review / docs?)


## Assumptions
This sections outlines some complications cosidered and the assumptions made about the issues.


### disjoint localites
It is likely that a real dataset would include many complications, the first one to come to mind is the idea of disjoint localities, I'm imaging something like a long track of land split by crown land could end up with something like two sets of locals. This has not been addressed in this project with the assumption that a simple workaround like two entries for the disjoint local is good enough for the current requirements.


### docker
Considering using docker build for the ci pipline but all dev was done on local for simplicity.

