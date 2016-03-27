export interface Tile {
  id: number;
  kind: string;
  order: number;
}

export interface User {
  id: number;
  name: string;
  room: Room;
  game: Game;
}

export enum Direction {
  East  = <any>"east",
  West  = <any>"west",
  South = <any>"south",
  North = <any>"north"
}
export interface Hand {
  id: number;
  tiles: Tile[];
}

export interface River {
  id: number;
  tiles: Tile[];
}

export enum Action {
  Discard  = <any>"discard",
  Draw     = <any>"draw",
  SelfPick = <any>"self_pick"
}

export interface Seat {
  id: number;
  point: number;
  position: Direction;
  river: River;
  hand: Hand;
  user: User;
}

export interface Game {
  id: number;
  name: string;
  wind: Direction;
  round_number: number;
  bonus_count: number;
  seats: Seat[];
  available_actions: Action;
  links: any;
}

export interface Room {
  id: number;
  users: User[];
  links: any;
  game: Game;
}
