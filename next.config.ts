import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  images: {
    remotePatterns: [
      {
        protocol: 'https',
        hostname: 'static.promediateknologi.id',
      },
      {
        protocol: 'https',
        hostname: 'monitorday.com',
      },
      {
        protocol: 'https',
        hostname: 'infopublik.id',
      },
      {
        protocol: 'https',
        hostname: 'www.nusabali.com',
      },
      {
        protocol: 'https',
        hostname: 'i1.wp.com',
      },
    ],
  },
};

export default nextConfig;
