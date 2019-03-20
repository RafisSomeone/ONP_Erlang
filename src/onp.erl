%%%-------------------------------------------------------------------
%%% @author rafal
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 19. mar 2019 23:04
%%%-------------------------------------------------------------------
-module(onp).
-author("rafal").

%% API
-export([onp/1]).

onp(Equation) ->
 parse(string:tokens(Equation," "),[]).


parse([],[]) ->
  "err";
parse([],[H|T]) ->
  case T of
    [] ->H;
    _ -> "err"
  end;
parse ([H|T],Stack)->
  case H of
    "+" -> parse(T,make_and_stack(H,Stack));
    "-" -> parse(T,make_and_stack(H,Stack));
    "*" -> parse(T,make_and_stack(H,Stack));
    "/" -> parse(T,make_and_stack(H,Stack));
    "sqrt" -> parse(T,make_and_stack(H,Stack));
    "pow" -> parse(T,make_and_stack(H,Stack));
    "sin" -> parse(T,make_and_stack(H,Stack));
    "cos" -> parse(T,make_and_stack(H,Stack));
    "tan" -> parse(T,make_and_stack(H,Stack));
    _-> parse (T,[convert(isFloat(H),H)] ++ Stack)
  end.
make_and_stack(O,[H| [ D | T ] ]) ->
  case O of
    "+" -> [D+H] ++ T;
    "-" -> [D-H] ++ T;
    "*" -> [D*H] ++ T;
    "/" -> [D/H] ++ T;
    "sqrt" -> math:sqrt(H) ++ T;
    "pow" ->[math:pow(D,H)] ++ T;
    "sin" -> math:sin(H) ++ T;
    "cos" -> math:cos(H) ++ T;
    "tan" -> math:tan(H) ++ T
  end.

isFloat([]) ->
  false;
isFloat([46|_]) ->
  true;
isFloat([_|T]) ->
  isFloat(T).

convert(true,V) ->
  list_to_float(V);
convert(false,V) ->
  list_to_integer(V).



