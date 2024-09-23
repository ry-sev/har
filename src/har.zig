/// HTTP Archive v1.2
pub const Har = struct {
    /// Root of the exported data
    log: Log,
};

/// Represents the root of the exported data
pub const Log = struct {
    /// Version number of the format
    version: []const u8 = "1.2",

    /// Name and version info of the log creator application
    creator: Creator,

    /// Name and version info of used browser
    browser: ?Browser = null,

    /// List of all exported (tracked) pages
    pages: ?[]Page = null,

    /// List of all exported (tracked) requests
    entries: []Entry,

    /// A comment provided by the user or the application
    comment: ?[]const u8 = null,
};

pub const Creator = struct {
    /// Name of the application used to export the log
    name: []const u8,

    /// Version of the application used to export the log
    version: []const u8,

    /// A comment provided by the user or the application
    comment: ?[]const u8 = null,
};

pub const Browser = struct {
    /// Name of the browser used to export the log
    name: []const u8,

    /// Version of the browser used to export the log
    version: []const u8,

    /// A comment provided by the user or the application
    comment: ?[]const u8 = null,
};

pub const Page = struct {
    /// Date and time stamp for the beginning of the page load (ISO 8601)
    startedDateTime: []const u8,

    /// Unique identifier of a page within the log. Entries use it to refer the parent page
    id: []const u8,

    /// Page title
    title: []const u8,

    /// Detailed timing info about page load
    pageTimings: PageTimings,

    /// A comment provided by the user or the application
    comment: ?[]const u8 = null,
};

/// Timings for various events (states) fired during the page load. All times are specified in milliseconds. If a time info is not available appropriate field is set to -1
pub const PageTimings = struct {
    onContentLoad: ?f64 = -1.0,
    onLoad: ?f64 = -1.0,
    comment: ?[]const u8 = null,
};

pub const Entry = struct {
    /// Unique Reference to the parent page
    pageref: ?[]const u8 = null,

    /// Date and time stamp of the request start (ISO 8601)
    startedDateTime: ?[]const u8 = null,

    /// Total elapsed time of the request in milliseconds. This is the sum of all timings available in the timings object (i.e. not including -1 values)
    time: f64 = 0,

    /// Detailed info about the request
    request: Request,

    /// Detailed info about the response
    response: Response,

    /// Info about cache usage
    cache: Cache,

    /// Detailed timing info about request/response round trip
    timings: Timings,

    /// IP address of the server that was connected (result of DNS resolution)
    serverIPAddress: ?[]const u8 = null,

    /// Unique ID of the parent TCP/IP connection, can be the client or server port number.
    connection: ?[]const u8 = null,

    /// A comment provided by the user or the application
    comment: ?[]const u8 = null,
};

/// Contains detailed info about performed request
pub const Request = struct {
    /// Request method
    method: []const u8,

    /// Absolute URL of the request (fragments are not included)
    url: []const u8,

    /// Request HTTP Version
    httpVersion: []const u8,

    /// List of cookie objects
    cookies: []Cookie,

    /// List of header objects
    headers: []Header,

    /// List of query parameter objects
    queryString: []QueryString,

    /// Posted data info
    postData: ?PostData = null,

    /// Total number of bytes from the start of the HTTP request message until (and including) the double CRLF before the body
    headersSize: f64 = -1.0,

    /// Size of the request body in bytes (e.g. POST data payload)
    bodySize: f64 = -1.0,

    /// A comment provided by the user or the application
    comment: ?[]const u8 = null,
};

pub const Response = struct {
    /// Response status
    status: u10,

    /// Response status description
    statusText: []const u8,

    /// Response HTTP Version
    httpVersion: []const u8,

    /// List of cookie objects
    cookies: []Cookie,

    /// List of header objects
    headers: []Header,

    /// Details about the response body
    content: Content,

    /// Redirection target URL from the Location response header
    redirectURL: []const u8,

    /// Total number of bytes from the start of the HTTP response message until (and including) the double CRLF before the body
    headersSize: f64 = -1.0,

    /// Size of the received response body in bytes. Set to 0 in case of responses coming from the cache (304)
    bodySize: f64 = -1.0,

    /// A comment provided by the user or the application
    comment: ?[]const u8 = null,
};

pub const Cookie = struct {
    /// The name of the cookie
    name: []const u8,

    /// The cookie value
    value: []const u8,

    /// The path pertaining to the cookie
    path: ?[]const u8 = null,

    /// The host of the cookie
    domain: ?[]const u8 = null,

    /// Cookie expiration time. (ISO 8601)
    expires: ?[]const u8 = null,

    /// Set to true if the cookie is HTTP only, false otherwise
    httpOnly: ?bool = null,

    /// true if the cookie was transmitted over ssl, false otherwise
    secure: ?bool = null,

    /// A comment provided by the user or the application
    comment: ?[]const u8 = null,
};

pub const Header = struct {
    /// The name of the header
    name: []const u8,

    /// The header value
    value: []const u8,

    ///  A comment provided by the user or the application
    comment: ?[]const u8 = null,
};

pub const QueryString = struct {
    /// The name of the query
    name: []const u8,

    /// The query value
    value: []const u8,

    /// A comment provided by the user or the application
    comment: ?[]const u8 = null,
};

pub const PostData = struct {
    /// Mime type of posted data
    mimeType: []const u8,

    /// List of posted parameters (in case of URL encoded parameters)
    params: ?[]Parameter = null,

    /// Plain text posted data
    text: []const u8,

    /// A comment provided by the user or the application
    comment: ?[]const u8 = null,
};

pub const Parameter = struct {
    /// Name of a posted parameter
    name: []const u8,

    /// Value of a posted parameter or content of a posted file
    value: ?[]const u8 = null,

    /// Name of a posted file
    fileName: ?[]const u8 = null,

    /// Content type of a posted file
    contentType: ?[]const u8 = null,

    /// A comment provided by the user or the application
    comment: ?[]const u8 = null,
};

pub const Content = struct {
    /// Length of the returned content in bytes. Should be equal to response.bodySize if there is no compression and bigger when the content has been compressed
    size: f64,

    /// Number of bytes saved
    compression: ?f64 = null,

    /// MIME type of the response text (value of the Content-Type response header). The charset attribute of the MIME type is included (if available)
    mimeType: []const u8,

    /// Response body sent from the server or loaded from the browser cache.
    text: ?[]const u8 = null,

    /// Encoding used for response text field e.g "base64"
    encoding: ?[]const u8 = null,

    /// A comment provided by the user or the application
    comment: ?[]const u8 = null,
};

pub const Cache = struct {
    /// State of a cache entry before the request
    beforeRequest: ?BeforeRequest = null,

    /// State of a cache entry after the request
    afterRequest: ?AfterRequest = null,

    /// A comment provided by the user or the application
    comment: ?[]const u8 = null,
};

pub const BeforeRequest = struct {
    /// Expiration time of the cache entry
    expires: ?[]const u8 = null,

    /// The last time the cache entry was opened
    lastAccess: []const u8,

    /// The current entity-tag for the selected representation, as determined at the conclusion of handling the request.
    etag: []const u8,

    /// The number of times the cache entry has been opened
    hitCount: f64,

    /// A comment provided by the user or the application
    comment: ?[]const u8 = null,
};

pub const AfterRequest = struct {
    /// Expiration time of the cache entry
    expires: ?[]const u8 = null,

    /// The last time the cache entry was opened
    lastAccess: []const u8,

    /// The current entity-tag for the selected representation, as determined at the conclusion of handling the request.
    etag: []const u8,

    /// The number of times the cache entry has been opened
    hitCount: f64,

    /// A comment provided by the user or the application
    comment: ?[]const u8 = null,
};

pub const Timings = struct {
    /// Time spent in a queue waiting for a network connection
    blocked: ?f64 = -1.0,

    /// DNS resolution time. The time required to resolve a host name
    dns: ?f64 = -1.0,

    /// Time required to create TCP connection
    connect: ?f64 = -1.0,

    /// Time required to send HTTP request to the server
    send: f64,

    /// Waiting for a response from the server
    wait: f64,

    /// Time required to read entire response from the server (or cache)
    receive: f64,

    /// Time required for SSL/TLS negotiation.
    ssl: ?f64 = null,

    /// A comment provided by the user or the application
    comment: ?[]const u8 = null,
};
