export interface Tile {
  id: number;
  kind: string;
}

export interface User {
  id: number;
  name: string;
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
  seats: Seat[];
  available_actions: Action;
}
