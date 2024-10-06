//
// Error parsing json data from: "https://dummyjson.com/products"
// The file "data.json" was produced by copy-pasting from the web browser.
// To remove error comment line 24 as apparently the deserializer cannot find "brand".
//

const std = @import("std");
const json = std.json;
const print = std.debug.print;

const json_data = @embedFile("data.json");

const Products = struct {
    products: []struct {
        id: usize,
        title: []const u8,
        description: []const u8,
        category: []const u8,
        price: f16,
        discountPercentage: f16,
        rating: f16,
        stock: usize,
        tags: [][]const u8,
        brand: []const u8,
        sku: []const u8,
        weight: usize,
        dimensions: struct {
            width: f16,
            height: f16,
            depth: f16,
        },
        warrantyInformation: []const u8,
        shippingInformation: []const u8,
        availabilityStatus: []const u8,
        reviews: []struct {
            rating: usize,
            comment: []const u8,
            date: []const u8,
            reviewerName: []const u8,
            reviewerEmail: []const u8,
        },
        returnPolicy: []const u8,
        minimumOrderQuantity: usize,
        meta: struct {
            createdAt: []const u8,
            updatedAt: []const u8,
            barcode: []const u8,
            qrCode: []const u8,
        },
        images: [][]const u8,
        thumbnail: []const u8,
    },
    total: usize,
    skip: usize,
    limit: usize,
};

pub fn main() !void {

    // Allocator stuff
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // Deserialize JSON
    const options = std.json.ParseOptions{
        .ignore_unknown_fields = true,
    };
    const parsed = try json.parseFromSlice(Products, allocator, json_data, options);
    defer parsed.deinit();
    const products = parsed.value;

    print("Products found: {d}\n", .{products.total});
}
