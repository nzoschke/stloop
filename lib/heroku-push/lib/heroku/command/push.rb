module Heroku::Command

  # push a slug for an app
  class Push < BaseWithApp

    # push
    #
    # push a slug for an app
    #
    #  -s, --slug SLUG         # path to compiled slug
    #  -r, --release RELEASE   # path to release data
    #
    def push
      app_name = extract_app
      slug_path = extract_option("--slug")
      release_path = extract_option("--release")
      if [slug_path, release_path].compact.empty?
        error(" !    slugc not in the PATH") if `which slugc`.empty?
        meta = heroku.releases_new(app_name)
        meta_file = Tempfile.new("meta")
        meta_file.write(YAML.dump(meta))
        meta_file.close
        begin
          system("bash -c 'slugc --repo-dir #{File.join(Dir.pwd, ".git")} --meta #{meta_file.path} --trace 2>&1'")
        ensure
          meta_file.unlink
        end
      elsif [slug_path, release_path].compact.size == 2
        meta = heroku.releases_new(app_name)
        display("Pushing slug... ", false)
        slug = File.read(slug_path)
        release = YAML.load(File.read(release_path))
        RestClient.put(meta["slug_put_url"], slug, :content_type => nil)
        display("done")

        display("Launching... ", false)
        payload = release.merge({
          "slug_version" => 2,
          "run_deploy_hooks" => true,
          "user" => heroku.user,
          "release_descr" => "Deploy slug",
          "head" => Digest::SHA1.hexdigest(Time.now.to_f.to_s),
          "slug_put_key" => meta["slug_put_key"],
          "stack" => meta["stack"]})
        release = heroku.releases_create(app_name, payload)
        display("done, #{release["release"]}")
      end
    end
  end
end
