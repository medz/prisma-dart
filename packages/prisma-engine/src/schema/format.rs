/// Formats the given schema string.
/// 
/// - `schema` - The schema string to format.
/// - `params` - The formatting parameters. See https://github.com/prisma/prisma-engines/blob/main/prisma-fmt/src/lib.rs#L54
/// 
/// Returns the formatted schema string.
/// 
/// ## Example
/// ```ignore
/// let formatted_schema = format(schema, &lsp_types::DocumentFormattingParams {
///     text_document: lsp_types::TextDocumentIdentifier {
///         uri: lsp_types::Url::parse("file://test.prisma").unwrap(),
///     },
///     options: lsp_types::FormattingOptions {
///         tab_size: 2,
///         insert_spaces: true,
///         properties: std::collections::HashMap::new(),
///     },
/// });
/// ```
pub fn format(schema: &str, params: &lsp_types::DocumentFormattingParams) -> String {
    // params convert to json string.
    let params = match serde_json::to_string(params) {
        Ok(params) => params,
        Err(err) => {
            log::warn!("Error serializing formatting params: {:?}", err);
            return schema.to_owned();
        }
    };

    // Call prisma-fmt.
    prisma_fmt::format(schema, params.as_str())
}