# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Description
# ==============================================================================
#
#   Functions that creates a view of the string on the IO.
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

"""
    _view!(pagerd::Pager)

Write the view of pager `pagerd` to the view buffer.

"""
function _view!(pagerd::Pager)
    # Get the available display size.
    rows, cols = _get_pager_display_size(pagerd)

    # Get the necessary variables.
    active_search_match_id = pagerd.active_search_match_id
    buf                    = pagerd.buf
    draw_ruler             = pagerd.draw_ruler
    frozen_columns         = pagerd.frozen_columns
    frozen_rows            = pagerd.frozen_rows
    lines                  = pagerd.lines
    num_lines              = pagerd.num_lines
    search_matches         = pagerd.search_matches
    start_col              = pagerd.start_col
    start_row              = pagerd.start_row
    title_rows             = pagerd.title_rows

    # Make sure that the argument values are correct.
    start_row < 1 && (start_row = 1)
    start_col < 1 && (start_col = 1)

    # Render the view
    rows_cropped, columns_cropped = textview(
        buf,
        lines,
        (start_row, -1, start_col, -1);
        active_match                = active_search_match_id,
        frozen_lines_at_beginning   = frozen_rows,
        frozen_columns_at_beginning = frozen_columns,
        maximum_number_of_lines     = rows,
        maximum_number_of_columns   = cols,
        search_matches              = search_matches,
        show_ruler                  = draw_ruler,
        title_lines                 = title_rows
    )

    # Write the information to the structure.
    pagerd.columns_cropped = columns_cropped
    pagerd.lines_cropped   = rows_cropped

    # Since we modified the `buf`, we need to request redraw.
    _request_redraw!(pagerd)

    return nothing
end
