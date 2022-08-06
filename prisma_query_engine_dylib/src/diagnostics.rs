

/// Represents a location in a datamodel's text representation.
#[derive(Debug, Clone, Copy, PartialEq)]
#[repr(C)]
pub struct Span {
    pub start: usize,
    pub end: usize,
}

#[derive(Debug, Clone, PartialEq)]
#[repr(C)]
pub struct DiagnosticsMessage {
  span: Span,
  message: *const u8,
}

/// Represents a list of validation or parser errors and warnings.
///
/// This is used to accumulate multiple errors and warnings during validation.
/// It is used to not error out early and instead show multiple errors at once.
#[derive(Debug)]
#[repr(C)]
pub struct Diagnostics {
    errors: *const DiagnosticsMessage,
    warnings: *const DiagnosticsMessage,
}

impl From<datamodel::diagnostics::Span> for Span {
    fn from(span: datamodel::diagnostics::Span) -> Self {
        Span {
            start: span.start,
            end: span.end,
        }
    }
}

impl From<datamodel::diagnostics::Diagnostics> for Diagnostics {
  fn from(diagnostics: datamodel::diagnostics::Diagnostics) -> Self {
    let mut errors = Vec::new();
    let mut warnings = Vec::new();
    for error in diagnostics.errors() {
      errors.push(DiagnosticsMessage {
        span: Span::from(error.span()),
        message: error.message().as_ptr(),
      });
    }

    for warning in diagnostics.warnings() {
      warnings.push(DiagnosticsMessage {
        span: Span::from(warning.span()),
        message: warning.message().as_ptr(),
      });
    }
    Diagnostics {
      errors: errors.as_ptr(),
      warnings: warnings.as_ptr(),
    }
  }
}