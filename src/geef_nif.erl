%%% @private
%%% NIF functions, not to be used directly.

-module(geef_nif).
-export([reference_list/1, reference_create/5,
	 reference_to_id/2, reference_glob/2, reference_lookup/2, reference_resolve/1,
	 reference_target/1, reference_type/1, odb_object_exists/2, odb_write/3]).

% repository operations
-export([repository_get_path/1, repository_get_odb/1, repository_open/1, repository_init/2,
	 repository_is_bare/1, repository_get_workdir/1, repository_discover/1]).

% oid parsing
-export([oid_fmt/1, oid_parse/1]).

% objects
-export([object_lookup/2, object_id/1, commit_tree_id/1, commit_tree/1, tree_bypath/2, blob_size/1, blob_content/1]).

% git_libgit2
-export([library_version/0]).

% revision walker
-export([revwalk_new/1, revwalk_push/3, revwalk_next/1, revwalk_sorting/2, revwalk_reset/1]).

% index
-export([index_new/0, index_write/1, index_write_tree/1, index_write_tree/2,
	 index_clear/1, index_read_tree/2]).

-on_load(load_enif/0).

-define(NIF_FN, nif_error(?LINE)).

-spec repository_open(iolist()) -> {ok, term()} | {error, term()}.
repository_open(_Val) ->
    nif_error(?LINE).

-spec repository_is_bare(term()) -> boolean().
repository_is_bare(_Handle) ->
    nif_error(?LINE).

-spec repository_get_path(term()) -> binary().
repository_get_path(_Val) ->
    nif_error(?LINE).

-spec repository_get_workdir(term()) -> binary().
repository_get_workdir(_Handle) ->
    nif_error(?LINE).

repository_get_odb(_Val) ->
    nif_error(?LINE).

-spec repository_init(iolist(), boolean()) -> term().
repository_init(_Path, _Bare) ->
    nif_error(?LINE).

-spec repository_discover(iolist()) -> {ok, string()} | error.
repository_discover(_Path) ->
    nif_error(?LINE).

reference_list(_Repo) ->
    nif_error(?LINE).

reference_create(_Repo, _Refname, _Type, _Target, _Force) ->
    ?NIF_FN.

reference_to_id(_Repo, _Refname) ->
    nif_error(?LINE).

reference_glob(_Repo, _Glob) ->
    nif_error(?LINE).

reference_lookup(_Repo, _Refname) ->
    nif_error(?LINE).

reference_target(_Handle) ->
    nif_error(?LINE).

reference_resolve(_Handle) ->
    nif_error(?LINE).

reference_type(_Handle) ->
    nif_error(?LINE).

odb_object_exists(_Val, _Val) ->
    nif_error(?LINE).

-spec odb_write(term, iolist(), atom()) -> term.
odb_write(_Handle, _Contents, _Type) ->
    nif_error(?LINE).

oid_fmt(_Oid) ->
    nif_error(?LINE).

oid_parse(_Sha) ->
    nif_error(?LINE).

object_lookup(_Repo, _Oid) ->
    nif_error(?LINE).

object_id(_Handle) ->
    nif_error(?LINE).

-spec commit_tree_id(term) -> binary().
commit_tree_id(_Handle) ->
    nif_error(?LINE).

-spec commit_tree(term) -> term().
commit_tree(_Handle) ->
    nif_error(?LINE).

-spec tree_bypath(term, iolist()) -> term().
tree_bypath(_TreeHandle, _Path) ->
    nif_error(?LINE).

-spec blob_size(term) -> {ok, integer()} | error.
blob_size(_ObjHandle) ->
    nif_error(?LINE).

-spec blob_content(term) -> {ok, binary()} | error.
blob_content(_ObjHandle) ->
    nif_error(?LINE).

-spec library_version() -> {integer, integer, integer}.
library_version() ->
    nif_error(?LINE).

revwalk_new(_Repo) ->
    ?NIF_FN.

revwalk_push(_Walk, _Id, _Hide) ->
    ?NIF_FN.

revwalk_next(_Walk) ->
    ?NIF_FN.

revwalk_sorting(_Walk, _Sort) ->
    ?NIF_FN.

revwalk_reset(_Walk) ->
    ?NIF_FN.

index_new() ->
    ?NIF_FN.

index_write(_Handle) ->
    ?NIF_FN.

index_write_tree(_Handle) ->
    ?NIF_FN.

index_write_tree(_Handle, _RepoHandle) ->
    ?NIF_FN.

index_read_tree(_Handle, _TreeHandle) ->
    ?NIF_FN.

index_clear(_Handle) ->
    ?NIF_FN.

nif_error(Line) ->
    erlang:nif_error({nif_not_loaded,module,?MODULE,line,Line}).

load_enif() ->
    case code:priv_dir(geef) of
        {error, bad_name} ->
            SoName = filename:join("priv", geef);
        Dir ->
            SoName = filename:join(Dir, geef)
    end,
    erlang:load_nif(SoName, 0).