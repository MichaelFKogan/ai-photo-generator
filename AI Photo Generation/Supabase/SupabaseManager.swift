//
//  SupabaseManager.swift
//  AI Photo Generation
//
//  Created by Mike K on 10/18/25.
//

import Foundation
import Supabase

class SupabaseManager {
    static let shared = SupabaseManager()
    
    // Replace with your actual Supabase URL and anon key
    let client: SupabaseClient
    
    private init() {
        self.client = SupabaseClient(
            supabaseURL: URL(string: "https://inaffymocuppuddsewyq.supabase.co")!,
            supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImluYWZmeW1vY3VwcHVkZHNld3lxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjA2MTQwMDgsImV4cCI6MjA3NjE5MDAwOH0.rsklD7VpItxb2UTCzH1RPYD8HWKpFifekJaUi8JYkNY"
        )
    }
}
