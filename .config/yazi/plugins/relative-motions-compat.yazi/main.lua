-- Wrapper around relative-motions that restores the ya.mgr_emit alias
-- removed in yazi 25.5.31+ (https://github.com/dedukun/relative-motions.yazi/issues/33).
-- Keeps the upstream plugin pristine so `ya pkg upgrade` stays safe.
return {
  setup = function(_, opts)
    ya.mgr_emit = ya.mgr_emit or ya.emit
    return require("relative-motions"):setup(opts)
  end,
  entry = function(_, job)
    ya.mgr_emit = ya.mgr_emit or ya.emit
    return require("relative-motions"):entry(job)
  end,
}
