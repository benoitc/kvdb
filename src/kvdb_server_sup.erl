%%%---- BEGIN COPYRIGHT -------------------------------------------------------
%%%
%%% Copyright (C) 2012 Feuerlabs, Inc. All rights reserved.
%%%
%%% This Source Code Form is subject to the terms of the Mozilla Public
%%% License, v. 2.0. If a copy of the MPL was not distributed with this
%%% file, You can obtain one at http://mozilla.org/MPL/2.0/.
%%%
%%%---- END COPYRIGHT ---------------------------------------------------------
%%% @author Ulf Wiger <ulf@feuerlabs.com>
%%% @hidden
%%% @doc
%%%   KVDB database instance supervisor
%%% @end
%%%
-module(kvdb_server_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).
-export([start_child/2]).
	 %% childspec/1]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    %% Children = childspecs(DBs = get_databases()),
    %% io:fwrite("DBs = ~p~n", [DBs]),
    {ok, { {simple_one_for_one, 5, 10},
	   [{id, {kvdb_server, start_link, []},
	     transient, 5000, worker, [kvdb_server]}] }}.


start_child(Name, Opts) ->
    supervisor:start_child(?MODULE, [Name, Opts]).

