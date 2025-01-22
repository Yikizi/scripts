#!/usr/bin/env nu

def close_tab [id, port] {
    http get $"http://localhost:($port)/json/close/($id)"
}

def main [...args] {
    let tabs = (http get $"http://localhost:($args.0)/json/list"
        | where type == "page"
        | select url id)
    mut unique = []
    for tab in $tabs {
        if ($tab.url in $unique) {
            close_tab $tab.id $args.0
        } else {
            $unique = $unique | append $tab.url
        }
    }
}
