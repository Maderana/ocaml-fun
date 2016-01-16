type story = {
  context : context;
  perturbation : event;
  adventure : event list;
  conclusion: context;
}

and context = { characters : character list }

and character = {
  name : string;
  state : state;
  location : location
}

and event =
  | Change of character * state
  | Action of character * action

and state = Happy | Hungry
and action = Eat | GoToRestaurant 
and location = Apartment | Restaurant
;;
